# This example toolchain file describes the cross compiler to use for
# the target architecture indicated in the configuration file.

# Basic cross system configuration
set(CMAKE_SYSTEM_NAME       Linux)
set(CMAKE_SYSTEM_PROCESSOR  arm)
set(CMAKE_SYSTEM_VERSION    1)

set(RASPIAN_BASE_DIR "/disk/workarea/joe/wa/rpi/raspbian")

# specify the cross compiler - adjust accord to compiler installation
# This uses the compiler-wrapper toolchain that buildroot produces
SET(TOOLCHAIN_TOP "${RASPIAN_BASE_DIR}/tools"
    CACHE PATH "Location of the clone of https://github.com/raspberrypi/tools.git")
    
SET(TOOLCHAIN_VARIANT "arm-rpi-4.9.3-linux-gnueabihf"
    CACHE STRING "Specific compiler variant to use from the tools repo")
    

set(SDKHOSTBINDIR               "${TOOLCHAIN_TOP}/arm-bcm2708/${TOOLCHAIN_VARIANT}/bin")
set(SDKTARGETSYSROOT            "${TOOLCHAIN_TOP}/arm-bcm2708/${TOOLCHAIN_VARIANT}/arm-linux-gnueabihf/sysroot")
set(TARGETPREFIX                "arm-linux-gnueabihf-")

SET(CMAKE_C_COMPILER            "${SDKHOSTBINDIR}/${TARGETPREFIX}gcc")
SET(CMAKE_CXX_COMPILER          "${SDKHOSTBINDIR}/${TARGETPREFIX}g++")
#SET(CMAKE_LINKER                "${SDKHOSTBINDIR}/${TARGETPREFIX}ld")
SET(CMAKE_ASM_COMPILER          "${SDKHOSTBINDIR}/${TARGETPREFIX}as")
SET(CMAKE_STRIP                 "${SDKHOSTBINDIR}/${TARGETPREFIX}strip")
SET(CMAKE_NM                    "${SDKHOSTBINDIR}/${TARGETPREFIX}nm")
#SET(CMAKE_AR                    "${SDKHOSTBINDIR}/${TARGETPREFIX}ar")
SET(CMAKE_OBJDUMP               "${SDKHOSTBINDIR}/${TARGETPREFIX}objdump")
SET(CMAKE_OBJCOPY               "${SDKHOSTBINDIR}/${TARGETPREFIX}objcopy")

SET(CMAKE_FIND_ROOT_PATH ${SDKTARGETSYSROOT})

# search for programs in the build host directories
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM   NEVER)

# for libraries and headers in the target directories
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY   ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE   ONLY)

SET(CMAKE_PREFIX_PATH                   /)

# these settings are specific to cFE/OSAL and determines which
# abstraction layers are built when using this toolchain
SET(CFE_SYSTEM_PSPNAME                  pc-linux)
SET(OSAL_SYSTEM_OSTYPE                  posix)

