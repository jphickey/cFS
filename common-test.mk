
CPUNAME ?= cpu1
INSTALL_DIR ?= $(O)/exe

COMPILED_MODULE_LIST := $(shell awk  '/@.*_VERSION@/ { app = gensub (/@(\w+)_VERSION@/, "\\1", 1, $$3); print toupper(app); }' $(O)/cfe_module_version.in)
TESTABLE_MODULE_LIST := SAMPLE_APP FM CF LC SC HK DS HS MM CS BP BPLIB
MODULE_LIST := $(filter $(COMPILED_MODULE_LIST),$(TESTABLE_MODULE_LIST))

ALL_OSAL_FUNC_TESTS += bin-sem-test
ALL_OSAL_FUNC_TESTS += bin-sem-timeout-test
ALL_OSAL_FUNC_TESTS += count-sem-test
ALL_OSAL_FUNC_TESTS += file-api-test
ALL_OSAL_FUNC_TESTS += file-sys-add-fixed-map-api-test
ALL_OSAL_FUNC_TESTS += idmap-api-test
ALL_OSAL_FUNC_TESTS += mutex-test
ALL_OSAL_FUNC_TESTS += osal-core-test
ALL_OSAL_FUNC_TESTS += queue-test
ALL_OSAL_FUNC_TESTS += sem-speed-test
ALL_OSAL_FUNC_TESTS += symbol-api-test
ALL_OSAL_FUNC_TESTS += time-base-api-test
ALL_OSAL_FUNC_TESTS += timer-add-api-test
ALL_OSAL_FUNC_TESTS += timer-test

# These functional tests require a network stack,
# so they can be skipped on platforms that may not have network
ifeq ($(SKIP_NET_TESTS),)
ALL_OSAL_FUNC_TESTS += network-api-test
ALL_OSAL_FUNC_TESTS += select-test
endif


ALL_OSAL_PARAM_TESTS += osal_core_UT
ALL_OSAL_PARAM_TESTS += osal_filesys_UT
ALL_OSAL_PARAM_TESTS += osal_file_UT
#ALL_OSAL_PARAM_TESTS += osal_loader_UT
ALL_OSAL_PARAM_TESTS += osal_network_UT
ALL_OSAL_PARAM_TESTS += osal_timer_UT


ALL_CFE_CORE_COVERAGE_TESTS += coverage-msg-ALL-testrunner
ALL_CFE_CORE_COVERAGE_TESTS += coverage-es-ALL-testrunner
ALL_CFE_CORE_COVERAGE_TESTS += coverage-evs-ALL-testrunner
ALL_CFE_CORE_COVERAGE_TESTS += coverage-fs-ALL-testrunner
ALL_CFE_CORE_COVERAGE_TESTS += coverage-sb-ALL-testrunner
ALL_CFE_CORE_COVERAGE_TESTS += coverage-tbl-ALL-testrunner
ALL_CFE_CORE_COVERAGE_TESTS += coverage-time-ALL-testrunner

ALL_CFE_CORE_COVERAGE_TESTS += resourceid_UT
ALL_CFE_CORE_COVERAGE_TESTS += sbr_map_direct_UT
ALL_CFE_CORE_COVERAGE_TESTS += sbr_map_hash_UT
ALL_CFE_CORE_COVERAGE_TESTS += sbr_route_unsorted_UT

ALL_CS_COVERAGE_TESTS += coverage-cs-cs_app_cmds-testrunner
ALL_CS_COVERAGE_TESTS += coverage-cs-cs_app-testrunner
ALL_CS_COVERAGE_TESTS += coverage-cs-cs_cmds-testrunner
ALL_CS_COVERAGE_TESTS += coverage-cs-cs_compute-testrunner
ALL_CS_COVERAGE_TESTS += coverage-cs-cs_eeprom_cmds-testrunner
ALL_CS_COVERAGE_TESTS += coverage-cs-cs_init-testrunner
ALL_CS_COVERAGE_TESTS += coverage-cs-cs_memory_cmds-testrunner
ALL_CS_COVERAGE_TESTS += coverage-cs-cs_table_cmds-testrunner
ALL_CS_COVERAGE_TESTS += coverage-cs-cs_table_processing-testrunner
ALL_CS_COVERAGE_TESTS += coverage-cs-cs_utils-testrunner

ALL_CF_COVERAGE_TESTS += coverage-cf-cf_app-testrunner
ALL_CF_COVERAGE_TESTS += coverage-cf-cf_cfdp-testrunner
ALL_CF_COVERAGE_TESTS += coverage-cf-cf_cfdp_r-testrunner
ALL_CF_COVERAGE_TESTS += coverage-cf-cf_cfdp_s-testrunner
ALL_CF_COVERAGE_TESTS += coverage-cf-cf_cfdp_sbintf-testrunner
ALL_CF_COVERAGE_TESTS += coverage-cf-cf_cfdp_dispatch-testrunner
ALL_CF_COVERAGE_TESTS += coverage-cf-cf_chunk-testrunner
ALL_CF_COVERAGE_TESTS += coverage-cf-cf_clist-testrunner
ALL_CF_COVERAGE_TESTS += coverage-cf-cf_cmd-testrunner
ALL_CF_COVERAGE_TESTS += coverage-cf-cf_codec-testrunner
ALL_CF_COVERAGE_TESTS += coverage-cf-cf_crc-testrunner
#ALL_CF_COVERAGE_TESTS += coverage-cf-cf_dispatch-testrunner
ALL_CF_COVERAGE_TESTS += coverage-cf-cf_timer-testrunner
ALL_CF_COVERAGE_TESTS += coverage-cf-cf_utils-testrunner

ALL_BPLIB_COVERAGE_TESTS += coverage-bplib_os-testrunner
ALL_BPLIB_COVERAGE_TESTS += coverage-bplib_v7-testrunner
ALL_BPLIB_COVERAGE_TESTS += coverage-bplib_mpool-testrunner
ALL_BPLIB_COVERAGE_TESTS += coverage-bplib_base-testrunner
ALL_BPLIB_COVERAGE_TESTS += coverage-bplib_cache-testrunner
ALL_BPLIB_COVERAGE_TESTS += coverage-bplib_common-testrunner


ALL_BP_COVERAGE_TESTS += coverage-bp-ALL-testrunner

ALL_FM_COVERAGE_TESTS += coverage-fm-fm_app-testrunner
ALL_FM_COVERAGE_TESTS += coverage-fm-fm_child-testrunner
ALL_FM_COVERAGE_TESTS += coverage-fm-fm_cmds-testrunner
ALL_FM_COVERAGE_TESTS += coverage-fm-fm_dispatch-testrunner
ALL_FM_COVERAGE_TESTS += coverage-fm-fm_cmd_utils-testrunner
ALL_FM_COVERAGE_TESTS += coverage-fm-fm_tbl-testrunner

ALL_LC_COVERAGE_TESTS += coverage-lc-lc_action-testrunner
ALL_LC_COVERAGE_TESTS += coverage-lc-lc_app-testrunner
ALL_LC_COVERAGE_TESTS += coverage-lc-lc_cmds-testrunner
ALL_LC_COVERAGE_TESTS += coverage-lc-lc_custom-testrunner
ALL_LC_COVERAGE_TESTS += coverage-lc-lc_dispatch-testrunner
ALL_LC_COVERAGE_TESTS += coverage-lc-lc_utils-testrunner
ALL_LC_COVERAGE_TESTS += coverage-lc-lc_watch-testrunner

ALL_DS_COVERAGE_TESTS += coverage-ds-ds_app-testrunner
ALL_DS_COVERAGE_TESTS += coverage-ds-ds_cmds-testrunner
ALL_DS_COVERAGE_TESTS += coverage-ds-ds_file-testrunner
ALL_DS_COVERAGE_TESTS += coverage-ds-ds_dispatch-testrunner
ALL_DS_COVERAGE_TESTS += coverage-ds-ds_table-testrunner

ALL_HS_COVERAGE_TESTS += coverage-hs-hs_app-testrunner
ALL_HS_COVERAGE_TESTS += coverage-hs-hs_cmds-testrunner
ALL_HS_COVERAGE_TESTS += coverage-hs-hs_dispatch-testrunner
ALL_HS_COVERAGE_TESTS += coverage-hs-hs_monitors-testrunner
ALL_HS_COVERAGE_TESTS += coverage-hs-hs_utils-testrunner

ALL_HK_COVERAGE_TESTS += coverage-hk-hk_app-testrunner
ALL_HK_COVERAGE_TESTS += coverage-hk-hk_dispatch-testrunner
ALL_HK_COVERAGE_TESTS += coverage-hk-hk_utils-testrunner

ALL_SC_COVERAGE_TESTS += coverage-sc-sc_app-testrunner
ALL_SC_COVERAGE_TESTS += coverage-sc-sc_atsrq-testrunner
ALL_SC_COVERAGE_TESTS += coverage-sc-sc_cmds-testrunner
ALL_SC_COVERAGE_TESTS += coverage-sc-sc_dispatch-testrunner
ALL_SC_COVERAGE_TESTS += coverage-sc-sc_loads-testrunner
ALL_SC_COVERAGE_TESTS += coverage-sc-sc_rtsrq-testrunner
ALL_SC_COVERAGE_TESTS += coverage-sc-sc_state-testrunner
ALL_SC_COVERAGE_TESTS += coverage-sc-sc_utils-testrunner

ALL_SAMPLE_APP_COVERAGE_TESTS += coverage-sample_app-sample_app-testrunner
ALL_SAMPLE_APP_COVERAGE_TESTS += coverage-sample_app-sample_app_dispatch-testrunner
ALL_SAMPLE_APP_COVERAGE_TESTS += coverage-sample_app-sample_app_cmds-testrunner
ALL_SAMPLE_APP_COVERAGE_TESTS += coverage-sample_app-sample_app_utils-testrunner

ALL_CFS_APP_COVERAGE_TESTS := $(foreach MOD,$(MODULE_LIST),$(ALL_$(MOD)_COVERAGE_TESTS))

#ALL_CFS_APP_COVERAGE_TESTS += $(ALL_CS_COVERAGE_TESTS)
#ALL_CFS_APP_COVERAGE_TESTS += $(ALL_CF_COVERAGE_TESTS)
#ALL_CFS_APP_COVERAGE_TESTS += $(ALL_BPLIB_COVERAGE_TESTS)
#ALL_CFS_APP_COVERAGE_TESTS += $(ALL_BP_COVERAGE_TESTS)
#ALL_CFS_APP_COVERAGE_TESTS += $(ALL_FM_COVERAGE_TESTS)
#ALL_CFS_APP_COVERAGE_TESTS += $(ALL_LC_COVERAGE_TESTS)
#ALL_CFS_APP_COVERAGE_TESTS += $(ALL_DS_COVERAGE_TESTS)
#ALL_CFS_APP_COVERAGE_TESTS += $(ALL_HS_COVERAGE_TESTS)
#ALL_CFS_APP_COVERAGE_TESTS += $(ALL_HK_COVERAGE_TESTS)
#ALL_CFS_APP_COVERAGE_TESTS += $(ALL_SC_COVERAGE_TESTS)

ALL_OSAL_COVERAGE_TESTS :=                      \
	coverage-shared-binsem-testrunner			\
    coverage-shared-clock-testrunner            \
    coverage-shared-common-testrunner           \
    coverage-shared-condvar-testrunner          \
    coverage-shared-countsem-testrunner         \
    coverage-shared-dir-testrunner              \
    coverage-shared-errors-testrunner           \
    coverage-shared-filesys-testrunner          \
    coverage-shared-file-testrunner             \
    coverage-shared-heap-testrunner             \
    coverage-shared-idmap-testrunner            \
    coverage-shared-module-testrunner           \
    coverage-shared-mutex-testrunner            \
    coverage-shared-network-testrunner          \
    coverage-shared-printf-testrunner           \
    coverage-shared-queue-testrunner            \
    coverage-shared-select-testrunner           \
    coverage-shared-sockets-testrunner          \
    coverage-shared-task-testrunner             \
    coverage-shared-timebase-testrunner         \
    coverage-shared-time-testrunner             \
    coverage-vxworks-binsem-testrunner          \
    coverage-vxworks-bsd-select-testrunner      \
    coverage-vxworks-bsd-sockets-testrunner     \
    coverage-vxworks-common-testrunner          \
    coverage-vxworks-console-bsp-testrunner     \
    coverage-vxworks-console-testrunner         \
    coverage-vxworks-countsem-testrunner        \
    coverage-vxworks-dirs-globals-testrunner    \
    coverage-vxworks-files-testrunner           \
    coverage-vxworks-filesys-testrunner         \
    coverage-vxworks-heap-testrunner            \
    coverage-vxworks-idmap-testrunner           \
    coverage-vxworks-loader-testrunner          \
    coverage-vxworks-mutex-testrunner           \
    coverage-vxworks-network-testrunner         \
    coverage-vxworks-no-loader-testrunner       \
    coverage-vxworks-no-condvar-testrunner      \
    coverage-vxworks-no-network-testrunner      \
    coverage-vxworks-no-sockets-testrunner      \
    coverage-vxworks-no-symtab-testrunner       \
    coverage-vxworks-no-shell-testrunner        \
    coverage-vxworks-posix-files-testrunner     \
    coverage-vxworks-posix-dirs-testrunner      \
    coverage-vxworks-posix-gettime-testrunner   \
    coverage-vxworks-posix-io-testrunner        \
    coverage-vxworks-queues-testrunner          \
    coverage-vxworks-shell-testrunner           \
    coverage-vxworks-sockets-testrunner         \
    coverage-vxworks-symtab-testrunner          \
    coverage-vxworks-tasks-testrunner           \
    coverage-vxworks-timebase-testrunner        \
	coverage-ut-mcp750-vxworks-testrunner

ALL_PSP_COVERAGE_TESTS :=                      \
	#coverage-pspmod-linux_sysmon-testrunner

ALL_TESTNAME_LIST += $(ALL_OSAL_COVERAGE_TESTS)
ALL_TESTNAME_LIST += $(ALL_OSAL_PARAM_TESTS)
ALL_TESTNAME_LIST += $(ALL_OSAL_FUNC_TESTS)
ALL_TESTNAME_LIST += $(ALL_CFE_CORE_COVERAGE_TESTS)
ALL_TESTNAME_LIST += $(ALL_CFS_APP_COVERAGE_TESTS)
ALL_TESTNAME_LIST += $(ALL_PSP_COVERAGE_TESTS)

ALL_TESTFILE_LIST := $(addprefix $(INSTALL_DIR)/$(CPUNAME)/, $(ALL_TESTNAME_LIST))

.PHONY: clean_logs all_tests all_logs all_checks

clean_logs:
	rm -f $(addsuffix .check,$(ALL_TESTFILE_LIST)) \
		$(addsuffix .log,$(ALL_TESTFILE_LIST))

all_logs: $(addsuffix .log,$(ALL_TESTFILE_LIST))
all_checks: $(addsuffix .check,$(ALL_TESTFILE_LIST))

all_tests: all_checks
	@echo  '*** SUCCESS ***'
