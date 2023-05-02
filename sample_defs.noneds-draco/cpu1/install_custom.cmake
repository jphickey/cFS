
message("inside install_custom cpu1")
target_include_directories(sch_lab.table INTERFACE
    $<TARGET_PROPERTY:cf,INCLUDE_DIRECTORIES>
    $<TARGET_PROPERTY:sc,INCLUDE_DIRECTORIES>
)

if (TARGET bp)
target_include_directories(sch_lab.table INTERFACE
    $<TARGET_PROPERTY:bp,INCLUDE_DIRECTORIES>
)
target_include_directories(bp.table INTERFACE
    $<TARGET_PROPERTY:cf,INCLUDE_DIRECTORIES>
)
endif()

add_cfe_tables(sample_app alt_sample_tbl.c alt2_sample_tbl2.c)
