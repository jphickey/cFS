#
# Core Flight Software CMake / GNU make wrapper
#
# ABOUT THIS MAKEFILE:
# This is actually part of the CMake alternative build system.
# It is a GNU-make wrapper that calls the CMake tools appropriately
# so that setting up a new build is fast and easy with no need to
# learn the CMake commands.  It also makes it easier to integrate
# the build with IDE tools such as Eclipse by providing a default
# makefile that has the common targets such as all/clean/etc.
#
# Use of this file is optional.
#
# This file is intended to be placed at the TOP-MOST level of the mission
# source tree, i.e. a level above "cfe".  Note this is outside the cfe
# repository which is why it cannot be delivered directly in place.
# To use it, simply copy it to the top directory.  As this just contains
# wrappers for the CMake targets, it is unlikely to change.  Projects
# are also free to customize this file and add their own targets after
# copying it to the top of the source tree.
#
# For _ALL_ targets defined in this file the build tree location may
# be specified via the "O" variable (i.e. make O=<my-build-dir> all).
# If not specified then the "build" subdirectory will be assumed.
#
# This wrapper defines the following major targets:
#  prep -- Runs CMake to create a new or re-configure an existing build tree
#    Note that multiple build trees can exist from a single source
#    Other control options (such as "SIMULATION") may be passed to CMake via
#    make variables depending on the mission build scripts.  These will be
#    cached in the build tree so they do not need to be set again thereafter.
#
#  all -- Build all targets in the CMake build tree
#
#  install -- Copy all files to the installation tree and run packaging scripts
#     The "DESTDIR" environment variable controls where the files are copied
#
#  clean -- Clean all targets in the CMake build tree, but not the build tree itself.
#
#  distclean -- Entirely remove the build directory specified by "O"
#      Note that after this the "prep" step must be run again in order to build.
#      Use caution with this as it does an rm -rf - don't set O to your home dir!
#
#  docs -- Build all doxygen source documentation.  The HTML documentation will be
#      generated under the build tree specified by "O".
#
#  test -- Run all unit tests defined in the build.  Unit tests will typically only
#      be executable when building with the "SIMULATION=native" option.  Otherwise
#      it is up to the user to copy the executables to the target and run them.
#
#  lcov -- Runs the "lcov" tool on the build tree to collect all code coverage
#      analysis data and build the reports.  Code coverage data may be output by
#      the "make test" target above.
#

# Provide default values for all important vars, which ensures they are never unset.
# However most are overridden on a per-target basis
O             ?= build
ARCH          ?= native
CFG           ?= none
INSTALLPREFIX ?= /exe
DESTDIR       ?= $(abspath $(O))
ENABLE_TESTS  ?= true
BUILDTYPE     ?= debug

# If using containers it is possible that the "native" gcc version
# might refer to a different version, if this is run in a container vs.
# outside the container.
NATIVE_GCC_VER := $(shell gcc --version | head -1 | awk -F\  '{print $$NF}')

# Define the separate output dir per config
# Each config listed in CONFIG_NAMES should have a corresponding O variable here
O_native ?= build-native-$(NATIVE_GCC_VER)
O_rtems  ?= build-rtems
O_rpi    ?= build-rpi
O_flight ?= build-flight
O_bplib  ?= build-bplib-standalone

# The "stamp" target names are associated with a file in the build dir to indicate last run time
# The "nostamp" target names do not have this, and are always executed
STAMPTGT_NAMES    := prep compile install test lcov detaildesign usersguide osalguide clean
NOSTAMPTGT_NAMES  := distclean docs

# The config names is a list of configurations to build
CONFIG_NAMES      := native rtems rpi flight bplib

# The actual buildable targets are a combination of CONFIG.NAME (e.g. native.install)
STAMP_TARGETS     := $(foreach CFG,$(CONFIG_NAMES),$(addprefix $(CFG).,$(STAMPTGT_NAMES)))
NOSTAMP_TARGETS   := $(foreach CFG,$(CONFIG_NAMES),$(addprefix $(CFG).,$(NOSTAMPTGT_NAMES)))

# A stamp target with a ".force" suffix removes the stamp file, thereby forcing a rebuild
FORCE_TARGETS     := $(addsuffix .force,$(STAMP_TARGETS))

# The complete list of targets available per-config
ALLTGT_NAMES      := $(STAMPTGT_NAMES) $(NOSTAMPTGT_NAMES)
ALL_TARGETS       := $(STAMP_TARGETS) $(NOSTAMP_TARGETS)

# Each config/arch also gets its own list of targets, for custom variable setting
NATIVE_TARGETS    := $(addprefix native.,$(ALLTGT_NAMES))
RTEMS_TARGETS     := $(addprefix rtems.,$(ALLTGT_NAMES))
RPI_TARGETS       := $(addprefix rpi.,$(ALLTGT_NAMES))
FLIGHT_TARGETS    := $(addprefix flight.,$(ALLTGT_NAMES))
BPLIB_TARGETS     := $(addprefix bplib.,$(ALLTGT_NAMES))

DISTCLEAN_TARGETS := $(addsuffix .distclean,$(CONFIG_NAMES))
DOCS_TARGETS      := $(addsuffix .docs,$(CONFIG_NAMES))

# Define the config (CFG) and build dir (O) for each target group
$(NATIVE_TARGETS): CFG := native
$(RTEMS_TARGETS):  CFG := rtems
$(RPI_TARGETS):    CFG := rpi
$(FLIGHT_TARGETS): CFG := flight
$(BPLIB_TARGETS):  CFG := bplib

# Define the ARCH used for each target group
$(BPLIB_TARGETS) \
$(NATIVE_TARGETS): ARCH := native
$(RTEMS_TARGETS):  ARCH := i686-rtems4.11
$(RPI_TARGETS):    ARCH := arm-raspbian-linux
$(FLIGHT_TARGETS): ARCH := ppc7400-poky-linux

# For all targets the O should be set to the per-config build dir
$(ALL_TARGETS):    O = $(O_$(CFG))

# Define extra prep options for each target group
# Note that because prep can also be triggered indirectly, the PREP_OPTS
# is set for all targets, not just the prep target itself
$(ALL_TARGETS):    PREP_OPTS += -DENABLE_UNIT_TESTS=$(ENABLE_TESTS)
$(ALL_TARGETS):    PREP_OPTS += -DCMAKE_EXPORT_COMPILE_COMMANDS=TRUE
$(RTEMS_TARGETS) \
$(RPI_TARGETS) \
$(NATIVE_TARGETS) \
$(FLIGHT_TARGETS): PREP_OPTS += -DCMAKE_INSTALL_PREFIX=$(INSTALLPREFIX) -DSIMULATION=$(ARCH)
$(RTEMS_TARGETS) \
$(RPI_TARGETS) \
$(NATIVE_TARGETS): PREP_OPTS += -DCMAKE_BUILD_TYPE=$(BUILDTYPE)
$(RPI_TARGETS) \
$(FLIGHT_TARGETS): ENV_OPTS += OMIT_DEPRECATED=true
$(FLIGHT_TARGETS): PREP_OPTS += -DCMAKE_BUILD_TYPE=release

$(RTEMS_TARGETS) \
$(RPI_TARGETS) \
$(NATIVE_TARGETS) \
$(FLIGHT_TARGETS): PREP_OPTS += "$(CURDIR)/cfe"

$(BPLIB_TARGETS):  PREP_OPTS += "$(CURDIR)/libs/bplib"
$(BPLIB_TARGETS):  PREP_OPTS += -DCMAKE_BUILD_TYPE=$(BUILDTYPE)
$(BPLIB_TARGETS):  PREP_OPTS += -DCMAKE_PREFIX_PATH=$(HOME)/code/local/lib/cmake
$(BPLIB_TARGETS):  PREP_OPTS +=	-DCMAKE_INSTALL_PREFIX=$(HOME)/code/local

# The following set of variables is exported to the sub-makes
export O
export ARCH
export CFG
export PREP_OPTS
export DESTDIR

# Export VERBOSE only if it was actually set to something
ifneq ($(VERBOSE),)
export VERBOSE
endif

# This is a translator from a virtual target (config.goal format) to a stamp file name
GET_STAMP_TARGET = $(O_$(basename $(1)))/stamp$(suffix $(1))

# A list of targets with a corresponding stamp file that was explicitly listed on command line
# These stamp files will be removed such that command line targets are always refreshed
COMMANDLINE_STAMPTGTS  := $(filter $(addprefix %.,$(STAMPTGT_NAMES)),$(MAKECMDGOALS))
COMMANDLINE_STAMPFILES := $(foreach GOAL,$(COMMANDLINE_STAMPTGTS),$(call GET_STAMP_TARGET,$(GOAL)))

.PHONY: $(ALLTGT_NAMES) $(ALL_TARGETS) .force

# The "world" target is a shorthand to build and tests all items possible
world: native.lcov native.docs flight.install rpi.install rtems.test
	@echo "WORLD BUILD COMPLETED"

# The "distclean" goal removes the entire build dir, including generated makefiles
$(DISTCLEAN_TARGETS):
	[ ! -z "$(O)" ] && rm -rf "$(O)"

# The "docs" target is just a meta target for all docs (detaildesign, usersguide, osalguide)
$(DOCS_TARGETS):  %.docs: %.detaildesign
$(DOCS_TARGETS):  %.docs: %.usersguide
$(DOCS_TARGETS):  %.docs: %.osalguide

build: .force
	rm -f build
	ln -s $(O_native) build

native.install: | build

# A generic pattern rule to remove a stamp file, ensuring target gets rebuilt
%.rm-stamp:
	-rm -f "$(@:%.rm-stamp=%)"

# A generic pattern rule to invoke CMake for the "prep" (makefile generation) step
%/stamp.prep:
	mkdir -p "$(O)"
	(cd "$(O)" && env $(ENV_OPTS) cmake $(PREP_OPTS) )
	echo "$(PREP_OPTS)" > "$(@)"

# A generic pattern rule to invoke a sub-make for the appliction compile only
%/stamp.compile: %/stamp.prep .force
	$(MAKE) --no-print-directory -C "$(O)" all
	touch "$(@)"

# A generic pattern rule to invoke a sub-make for the appliction build/install to staging area
%/stamp.install: %/stamp.prep .force
	$(MAKE) --no-print-directory -C "$(O)" mission-install
	touch "$(@)"

# A generic pattern rule to clean a build area
%/stamp.clean: %/stamp.prep
	$(MAKE) --no-print-directory -C "$(O)" mission-clean
	touch "$(@)"

# A generic pattern rule to invoke a sub-make for running tests
%/stamp.test: %/stamp.install
	$(MAKE) --no-print-directory -f $(CFG)-test.mk all_tests
	touch "$(@)"

# A generic pattern rule to invoke a sub-make for running coverage analysis
%/stamp.lcov: %/stamp.test
	$(MAKE) --no-print-directory -f $(CFG)-test.mk all_lcov
	touch "$(@)"

# A generic pattern rule to invoke a sub-make for building detail design doc
%/stamp.detaildesign: %/stamp.prep .force
	$(MAKE) --no-print-directory -C "$(O)" mission-doc
	touch "$(@)"

# A generic pattern rule to invoke a sub-make for building user guide doc
%/stamp.usersguide: %/stamp.prep .force
	$(MAKE) --no-print-directory -C "$(O)" cfe-usersguide
	touch "$(@)"

# A generic pattern rule to invoke a sub-make for building osal guide doc
%/stamp.osalguide: %/stamp.prep .force
	$(MAKE) --no-print-directory -C "$(O)" osal-apiguide
	touch "$(@)"

# also define targets which builds all configs (except world, which has custom rule above)
# This utilizes "second expansion" feature of gnu make so that $@ may be referenced in prereq list
.SECONDEXPANSION:
$(ALLTGT_NAMES):  $$(addsuffix .$$(@),$(CONFIG_NAMES))
$(STAMP_TARGETS): $$(call GET_STAMP_TARGET,$$(@))
# Ensure that stampfiles related to command-line goals are always refreshed
$(COMMANDLINE_STAMPFILES): $$(addsuffix .rm-stamp,$$(@))
