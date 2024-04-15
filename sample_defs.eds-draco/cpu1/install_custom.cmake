install(FILES /usr/lib/x86_64-linux-gnu/liblua5.3.so.0.0.0
	DESTINATION ${TGTNAME}/${INSTALL_SUBDIR}
	RENAME liblua.so
)

INSTALL(SCRIPT ${MISSION_SOURCE_DIR}/sample_defs.eds-draco/ui/gen-lighttpd-run.cmake)
INSTALL(FILES ${MISSION_SOURCE_DIR}/sample_defs.eds-draco/ui/lighttpd.conf DESTINATION ${UI_INSTALL_SUBDIR})

