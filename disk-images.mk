
CFE_IMG_MB ?= 30
CPUNAME ?= cpu1
QEMU_MACHINE ?= ppce500
QEMU_ARCH ?= ppc
YOCTO_MACHINETYPE ?= qemu$(QEMU_ARCH)
O ?= build-$(YOCTO_MACHINETYPE)
INSTALL_DIR ?= $(O)/exe
CFE_DISK_IMG ?= $(INSTALL_DIR)/$(CPUNAME)-$(YOCTO_MACHINETYPE)-disk.img
CFE_FS_IMG ?= $(INSTALL_DIR)/$(CPUNAME)-$(YOCTO_MACHINETYPE)-cfe-fs.img
#KERNEL_NAME ?= bzImage
KERNEL_NAME ?= vmlinux
BASE_DISK_IMG ?= $(INSTALL_DIR)/$(YOCTO_MACHINETYPE)-disk.img
YOCTO_DIR ?= /disk/workarea/joe/wa/yocto/build-cfetest-dunfell
YOCTO_DEPLOY_PATH ?= $(YOCTO_DIR)/tmp/deploy/images/$(YOCTO_MACHINETYPE)
YOCTO_DEPLOY_FS ?= $(YOCTO_DEPLOY_PATH)/core-image-cfecfs-$(YOCTO_MACHINETYPE).ext4
QEMU_COMMAND ?= qemu-system-ppc -M $(QEMU_MACHINE) -m 256

.PHONY: all run cfe-disk base-disk

all: base-disk cfe-disk
base-disk: $(BASE_DISK_IMG).stamp
cfe-disk: $(CFE_DISK_IMG).stamp

$(CFE_DISK_IMG):  FS_SIZE := $(shell echo $$(($(CFE_IMG_MB) * 1048576)))
$(BASE_DISK_IMG): FS_SIZE := $(shell stat -L -c %s $(YOCTO_DEPLOY_FS))

$(CFE_DISK_IMG) $(BASE_DISK_IMG):
	truncate -s $$((2 + ($(FS_SIZE) / 1048576)))M  $(@)
	parted -s $(@) mklabel msdos
	parted -s $(@) mkpart primary 1M 100%

$(CFE_FS_IMG): $(O)/install.stamp
	genext2fs -b $$(($(CFE_IMG_MB)*1024)) -d $(INSTALL_DIR)/$(CPUNAME) -U $@
	e2fsck -f -y $@


$(CFE_DISK_IMG).stamp: $(CFE_DISK_IMG) $(CFE_FS_IMG)
	dd if=$(CFE_FS_IMG) of=$(CFE_DISK_IMG) bs=1024 seek=1024
	touch $(@)

$(BASE_DISK_IMG).stamp: $(BASE_DISK_IMG) $(YOCTO_DEPLOY_FS)
	dd if=$(YOCTO_DEPLOY_FS) of=$(BASE_DISK_IMG) bs=1024 seek=1024
	touch $(@)

run: all
	$(QEMU_COMMAND) -nographic -no-reboot \
	    -kernel $(YOCTO_DEPLOY_PATH)/$(KERNEL_NAME) \
    	-drive file=$(BASE_DISK_IMG),format=raw \
	    -drive file=$(CFE_DISK_IMG),format=raw \
		-append 'root=/dev/hda1 rw console=ttyS0 console=tty' \
    	-device virtio-net,netdev=net0,mac=00:04:9F:00:27:61 \
	    -netdev user,id=net0,hostfwd=udp:127.0.0.1:1235-:1235
