install(FILES /usr/lib/x86_64-linux-gnu/liblua5.3.so.0.0.0
	DESTINATION ${TGTNAME}/${INSTALL_SUBDIR}
	RENAME liblua.so
)

#target_include_directories(cpu1_sch_lab_table_sch_lab_table PRIVATE
#    $<TARGET_PROPERTY:hs,INCLUDE_DIRECTORIES>
#)

add_cfe_tables(to_lab to_lab_sub_custom.c)
add_cfe_tables(sch_lab sch_lab_table_custom.c)
