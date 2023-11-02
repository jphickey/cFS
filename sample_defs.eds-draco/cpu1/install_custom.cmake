install(FILES /usr/lib/x86_64-linux-gnu/liblua5.3.so.0.0.0
	DESTINATION ${TGTNAME}/${INSTALL_SUBDIR}
	RENAME liblua.so
)

INSTALL(SCRIPT ${MISSION_SOURCE_DIR}/sample_defs.eds-draco/ui/gen-lighttpd-run.cmake)
INSTALL(FILES ${MISSION_SOURCE_DIR}/sample_defs.eds-draco/ui/lighttpd.conf DESTINATION ${UI_INSTALL_SUBDIR})


add_cfe_tables(to_lab tables/to_lab_sub_custom.c)
add_cfe_tables(sch_lab tables/sch_lab_table_custom.c)
