install(FILES /usr/lib/x86_64-linux-gnu/liblua5.3.so.0.0.0
	DESTINATION ${TGTNAME}/${INSTALL_SUBDIR}
	RENAME liblua.so
)

add_cfe_tables(to_lab tables/to_lab_sub_custom.c)
add_cfe_tables(sch_lab tables/sch_lab_table_custom.c)
