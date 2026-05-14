
# For the native builds, include a wrapper script to start cFS on the container.
if (${SIMULATION} MATCHES "^native")
    install(PROGRAMS ${CMAKE_CURRENT_LIST_DIR}/container-start DESTINATION cpu1)
endif()

set(APP_INCLUDE_TABLE_LIST)
set(APP_DEFINITION_LIST)
foreach(APP ${TGTSYS_${SYSVAR}_APPS})
  if (TARGET ${APP})
    list(APPEND APP_INCLUDE_TABLE_LIST $<TARGET_PROPERTY:${APP},INTERFACE_INCLUDE_DIRECTORIES>)
    string(TOUPPER "HAVE_${APP}" APP_MACRO)
    list(APPEND APP_DEFINITION_LIST ${APP_MACRO})
  endif()
endforeach()

# specify extra include dirs for to_lab + sch_lab table builds
target_include_directories(to_lab.table  INTERFACE ${APP_INCLUDE_TABLE_LIST})
target_compile_definitions(to_lab.table  INTERFACE ${APP_DEFINITION_LIST})
target_include_directories(sch_lab.table INTERFACE ${APP_INCLUDE_TABLE_LIST})
target_compile_definitions(sch_lab.table INTERFACE ${APP_DEFINITION_LIST})

if ("${CMAKE_C_COMPILER_ID}" STREQUAL "GNU" AND CMAKE_C_COMPILER_VERSION VERSION_GREATER_EQUAL 14.0.0)
  target_compile_options(ut_coverage_compile INTERFACE -fcondition-coverage -fprofile-abs-path)
endif()

add_cfe_tables(sample_app sample_app_alt1.c)
#add_cfe_tables(sch_lab sch_lab_custom.lua)
