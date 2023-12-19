# CMake snippet for building the host-side tools.
#project(CFETOOLS C)
#


# build the EDS tool set which is used later in the build
message(STATUS "Setting up EDS toolchain build...")
add_subdirectory(eds/edslib)
add_subdirectory(eds/tool)
add_subdirectory(eds/cfecfs)

add_custom_command(
    OUTPUT
        "${MISSION_BINARY_DIR}/edstool-complete.stamp"
    COMMAND sedstool
        -DBUILD_TOOL="${CMAKE_BUILD_TOOL}"
        -DCFLAGS="${CMAKE_C_FLAGS}"
        -DCC="${CMAKE_C_COMPILER}"
        -DAR="${CMAKE_AR}"
        -DOBJDIR="obj"
        -DMISSION_BINARY_DIR="${MISSION_BINARY_DIR}"
        -DMISSION_NAME="${MISSION_NAME}"
        ${MISSION_EDS_FILELIST}
        ${MISSION_EDS_SCRIPTLIST}
    COMMAND ${CMAKE_COMMAND}
        -E touch "edstool-complete.stamp"
    WORKING_DIRECTORY
        "${MISSION_BINARY_DIR}"
    DEPENDS
        sedstool
        ${MISSION_EDS_FILELIST}
        ${MISSION_EDS_SCRIPTLIST}
)

add_custom_target(edstool-execute
    DEPENDS
        "${MISSION_BINARY_DIR}/edstool-complete.stamp"
)

# Executing the EDS tool per above custom commands is hooked into
# the pre-build process so it is done before any CPU builds.
add_dependencies(mission-prebuild edstool-execute)
