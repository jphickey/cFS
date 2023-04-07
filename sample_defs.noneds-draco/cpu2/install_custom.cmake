
message("inside install_custom cpu2")
target_include_directories(tblobj_cpu2_sch_lab PRIVATE
    $<TARGET_PROPERTY:cf,INCLUDE_DIRECTORIES>
    $<TARGET_PROPERTY:bp,INCLUDE_DIRECTORIES>
)
target_include_directories(tblobj_cpu2_bp PRIVATE
    $<TARGET_PROPERTY:cf,INCLUDE_DIRECTORIES>
)
#add_cfe_tables(sample_app alt_sample_tbl.c alt2_sample_tbl.c)
