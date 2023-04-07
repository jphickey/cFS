
message("inside install_custom cpu1")
target_include_directories(tblobj_cpu1_sch_lab PRIVATE
    $<TARGET_PROPERTY:cf,INCLUDE_DIRECTORIES>
    $<TARGET_PROPERTY:sc,INCLUDE_DIRECTORIES>
)

if (TARGET tblobj_cpu1_bp)
target_include_directories(tblobj_cpu1_sch_lab PRIVATE
    $<TARGET_PROPERTY:bp,INCLUDE_DIRECTORIES>
)
target_include_directories(tblobj_cpu1_bp PRIVATE
    $<TARGET_PROPERTY:cf,INCLUDE_DIRECTORIES>
)
endif()

#add_cfe_tables(sample_app alt_sample_tbl.c alt2_sample_tbl.c)
