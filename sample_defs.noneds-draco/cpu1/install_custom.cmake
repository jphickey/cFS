
message("inside install_custom cpu1")
target_include_directories(cpu1_sch_lab_table_sch_lab_table PRIVATE
    $<TARGET_PROPERTY:cf,INCLUDE_DIRECTORIES>
    $<TARGET_PROPERTY:sc,INCLUDE_DIRECTORIES>
)

if (TARGET cpu1_bp_bp_flowtable)
target_include_directories(cpu1_sch_lab_table_sch_lab_table PRIVATE
    $<TARGET_PROPERTY:bp,INCLUDE_DIRECTORIES>
)
target_include_directories(cpu1_bp_bp_flowtable PRIVATE
    $<TARGET_PROPERTY:cf,INCLUDE_DIRECTORIES>
)
endif()

#add_cfe_tables(sample_app alt_sample_tbl.c alt2_sample_tbl.c)
