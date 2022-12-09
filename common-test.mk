
CPUNAME ?= cpu1
INSTALL_DIR ?= $(O)/exe

ALL_OSAL_FUNC_TESTS :=          	\
    bin-sem-flush-test		\
    bin-sem-test			\
    bin-sem-timeout-test	\
    count-sem-test			\
    file-api-test			\
    file-sys-add-fixed-map-api-test	\
    idmap-api-test			\
    mutex-test				\
    osal-core-test			\
    queue-test		        \
    sem-speed-test			\
    symbol-api-test			\
    time-base-api-test		\
    timer-add-api-test		\
    timer-test

# These functional tests require a network stack,
# so they can be skipped on platforms that may not have network
ifeq ($(SKIP_NET_TESTS),)
ALL_OSAL_FUNC_TESTS +=      \
    network-api-test		\
    select-test
endif


ALL_OSAL_PARAM_TESTS :=          	\
    osal_core_UT           \
    osal_filesys_UT        \
    osal_file_UT           \
    osal_loader_UT         \
    osal_network_UT        \
    osal_timer_UT          \


ALL_CFE_CORE_COVERAGE_TESTS :=      \
	coverage-es-ALL-testrunner      \
    coverage-evs-ALL-testrunner     \
    coverage-fs-ALL-testrunner      \
    coverage-sb-ALL-testrunner      \
    coverage-tbl-ALL-testrunner     \
    coverage-time-ALL-testrunner

#ALL_CFE_CORE_COVERAGE_TESTS += msg_UT
ALL_CFE_CORE_COVERAGE_TESTS += resourceid_UT
ALL_CFE_CORE_COVERAGE_TESTS += sbr_map_direct_UT
ALL_CFE_CORE_COVERAGE_TESTS += sbr_map_hash_UT

ALL_CFE_COVERAGE_TESTS += $(ALL_CFE_CORE_COVERAGE_TESTS)

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
ALL_CF_COVERAGE_TESTS += coverage-cf-cf_timer-testrunner
ALL_CF_COVERAGE_TESTS += coverage-cf-cf_utils-testrunner
#ALL_CFE_COVERAGE_TESTS += $(ALL_CF_COVERAGE_TESTS)

ALL_BPLIB_COVERAGE_TESTS += coverage-bplib_common-testrunner
ALL_BPLIB_COVERAGE_TESTS += coverage-bplib_mpool-testrunner
ALL_BPLIB_COVERAGE_TESTS += coverage-bplib_os-testrunner
ALL_BPLIB_COVERAGE_TESTS += coverage-bplib_base-testrunner
ALL_BPLIB_COVERAGE_TESTS += coverage-bplib_v7-testrunner
ALL_BPLIB_COVERAGE_TESTS += coverage-bplib_cache-testrunner
ALL_CFE_COVERAGE_TESTS += $(ALL_BPLIB_COVERAGE_TESTS)

ALL_BP_COVERAGE_TESTS += coverage-bp-ALL-testrunner
#ALL_CFE_COVERAGE_TESTS += $(ALL_BP_COVERAGE_TESTS)

ALL_FM_COVERAGE_TESTS += coverage-fm-fm_app-testrunner
ALL_FM_COVERAGE_TESTS += coverage-fm-fm_child-testrunner
ALL_FM_COVERAGE_TESTS += coverage-fm-fm_cmds-testrunner
ALL_FM_COVERAGE_TESTS += coverage-fm-fm_cmd_utils-testrunner
ALL_FM_COVERAGE_TESTS += coverage-fm-fm_tbl-testrunner
#ALL_CFE_COVERAGE_TESTS += $(ALL_FM_COVERAGE_TESTS)


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

ALL_CFE_TEST_LIST := $(addprefix $(INSTALL_DIR)/$(CPUNAME)/, \
    $(ALL_CFE_COVERAGE_TESTS)                            \
)

ALL_OS_TEST_COV_LIST := $(addprefix $(INSTALL_DIR)/$(CPUNAME)/, \
    $(ALL_OSAL_COVERAGE_TESTS)                           \
)

ALL_OS_TEST_PARAM_LIST := $(addprefix $(INSTALL_DIR)/$(CPUNAME)/, \
    $(ALL_OSAL_PARAM_TESTS)                                    \
)

ALL_OS_TEST_FUNC_LIST := $(addprefix $(INSTALL_DIR)/$(CPUNAME)/, \
    $(ALL_OSAL_FUNC_TESTS)                                    \
)


ALL_TEST_LIST := \
	$(ALL_CFE_TEST_LIST) \
	$(ALL_OS_TEST_COV_LIST) \
	$(ALL_OS_TEST_PARAM_LIST) \
	$(ALL_OS_TEST_FUNC_LIST) \

.PHONY: clean_logs \
	all_tests \
	all_logs \
	all_checks \
	all_cfe_cov_logs \
	all_osal_cov_logs \
	all_osal_param_logs \
	all_osal_func_logs

clean_logs:
	rm -f $(addsuffix .check,$(ALL_TEST_LIST)) \
		$(addsuffix .log,$(ALL_TEST_LIST))

all_logs: $(addsuffix .log,$(ALL_TEST_LIST))
all_checks: $(addsuffix .check,$(ALL_TEST_LIST))

all_cfe_cov_logs: $(addsuffix .log,$(ALL_CFE_TEST_LIST))
all_osal_cov_logs: $(addsuffix .log,$(ALL_OS_TEST_COV_LIST))
all_osal_param_logs: $(addsuffix .log,$(ALL_OS_TEST_PARAM_LIST))
all_osal_func_logs: $(addsuffix .log,$(ALL_OS_TEST_FUNC_LIST))

all_tests: all_checks
	@echo  '*** SUCCESS ***'
