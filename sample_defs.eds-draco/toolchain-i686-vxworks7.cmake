# This example toolchain file describes the cross compiler to use for
# the target architecture indicated in the configuration file.

# Basic cross system configuration
set(CMAKE_SYSTEM_NAME VxWorks-CFE)
set(CMAKE_SYSTEM_PROCESSOR i686)
set(CMAKE_SYSTEM_VERSION 7.0)

# Top level directory of the SDK install
#set(WIND_SDK_TOOLKIT $ENV{HOME}/code/windriver/wrsdk-vxworks7-qemu)

# Additional derived environment vars are from the environment
# provided by the SDK setup script
#set(ENV{WIND_SDK_BIN} $ENV{WIND_SDK_TOOLKIT}/bin)
#set(ENV{WIND_SDK_INCLUDE} $ENV{WIND_SDK_TOOLKIT}/include)
#set(ENV{WIND_SDK_COMPILERS} $ENV{WIND_SDK_TOOLKIT}/compilers)
#set(ENV{WIND_SDK_LIB} $ENV{WIND_SDK_TOOLKIT}/lib)
#set(ENV{WIND_SDK_LICENSE} $ENV{WIND_SDK_TOOLKIT}/license)
#set(ENV{WIND_SDK_HOST_TYPE} x86-linux2)
#set(ENV{WIND_SDK_VX7_HOST_TYPE} x86_64-linux)
#set(ENV{WIND_SDK_LLVM_COMPILER} llvm-8.0.0.1)
#set(ENV{WIND_SDK_LLVM_HOST_TYPE} LINUX64)
#set(ENV{WIND_SDK_LLVM_PATH} $ENV{WIND_SDK_TOOLKIT}/compilers/llvm-8.0.0.1)
#set(ENV{WIND_SDK_COMPILER_PATH} $ENV{WIND_SDK_TOOLKIT}/compilers/llvm-8.0.0.1/LINUX64/bin)
#set(ENV{WIND_TOOLS} $ENV{WIND_SDK_BIN})
#set(ENV{WIND_PYTHON_PATH} $ENV{WIND_SDK_LIB}/python)
#set(ENV{WRSD_LICENSE_FILE} $ENV{WIND_SDK_LICENSE})
#set(ENV{LD_LIBRARY_PATH} $ENV{WIND_SDK_LIB}:$ENV{LD_LIBRARY_PATH})

set(VXWORKS_TARGETPREFIX x86-wrs-vxworks-)

# The VxWorks toolchain relies on several environment variables,
# which should be set already by an environment setup script.

# specify the cross compiler - adjust accord to compiler installation
# This uses the compiler-wrapper toolchain that buildroot produces
SET(SDKHOSTBINDIR               "$ENV{WIND_SDK_TOOLKIT}/bin")

#set(VXWORKS_BSP_C_FLAGS           "-march=i686 -mtune=i686 -fno-common")
#set(VXWORKS_BSP_CXX_FLAGS         ${VXWORKS_BSP_C_FLAGS})

SET(CMAKE_C_COMPILER            "${SDKHOSTBINDIR}/${VXWORKS_TARGETPREFIX}cc")
SET(CMAKE_CXX_COMPILER          "${SDKHOSTBINDIR}/${VXWORKS_TARGETPREFIX}cxx")
SET(CMAKE_LINKER                "${SDKHOSTBINDIR}/${VXWORKS_TARGETPREFIX}ld")
SET(CMAKE_ASM_COMPILER          "${SDKHOSTBINDIR}/${VXWORKS_TARGETPREFIX}as")
SET(CMAKE_AR                    "${SDKHOSTBINDIR}/${VXWORKS_TARGETPREFIX}ar")
SET(CMAKE_OBJDUMP               "${SDKHOSTBINDIR}/${VXWORKS_TARGETPREFIX}objdump")
SET(CMAKE_RANLIB                "${SDKHOSTBINDIR}/${VXWORKS_TARGETPREFIX}ranlib")

# search for programs in the build host directories
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM   NEVER)

# for libraries and headers in the target directories
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY   ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE   ONLY)

SET(CMAKE_PREFIX_PATH                   /)

# these settings are specific to cFE/OSAL and determines which
# abstraction layers are built when using this toolchain
SET(CFE_SYSTEM_PSPNAME                  mcp750-vxworks)

#include_directories(${WIND_BASE}/target/h/wrn/coreip)
#include_directories(${WIND_BASE}/target/h) 

#SET(CMAKE_C_FLAGS_INIT "-include ${WIND_SDK_TOOLKIT}/usr/h/public/vxWorks.h " 
#    CACHE STRING "C Flags required by platform")

#SET(CMAKE_CXX_FLAGS_INIT "-include vxWorks.h " 
#    CACHE STRING "C Flags required by platform")
