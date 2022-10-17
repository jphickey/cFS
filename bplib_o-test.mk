# At a minimum the variable O must be set by the caller
ifeq ($(O),)
$(error O must be set prior to invoking this makefile)
endif

ALL_BPLIB_COVERAGE_TESTS += $(O)/common/ut-coverage/coverage-bplib_common-testrunner
ALL_BPLIB_COVERAGE_TESTS += $(O)/v7/ut-coverage/coverage-bplib_v7-testrunner
ALL_BPLIB_COVERAGE_TESTS += $(O)/lib/ut-coverage/coverage-bplib_base-testrunner
ALL_BPLIB_COVERAGE_TESTS += $(O)/os/ut-coverage/coverage-bplib_os-testrunner
ALL_BPLIB_COVERAGE_TESTS += $(O)/cache/ut-coverage/coverage-bplib_cache-testrunner
ALL_BPLIB_COVERAGE_TESTS += $(O)/mpool/ut-coverage/coverage-bplib_mpool-testrunner

ALL_TEST_LIST += $(ALL_BPLIB_COVERAGE_TESTS)
ALL_LOGFILE_LIST := $(addsuffix .log,$(ALL_TEST_LIST))

.PHONY: all_tests all_lcov clean_lcov force

all_logs: | clean_lcov

$(O)/coverage_test.info: force
	lcov --capture --rc lcov_branch_coverage=1 --directory "$(O)" --output-file "$(O)/coverage_test.info"

clean_lcov:
	find "$(O)" -type f -name '*.gcno' -o -name '*.gcda' -print0 | xargs -0 rm -f
	-rm -f $(O)/coverage_test.info

%.log: %
	cd $(dir $(*)) && ./$(notdir $(*)) > $(notdir $(*).logtmp)
	@mv -v $(*).logtmp $(@)

all_lcov: $(O)/coverage_test.info
	genhtml "$(O)/coverage_test.info" --branch-coverage --output-directory "$(O)/lcov"
	@/bin/echo -e "\n\nCoverage Report Link: file://$(abspath $(O))/lcov/index.html\n"

.PHONY: clean_logs \
	all_tests \
	all_logs

clean_logs:
	rm -f $(ALL_LOGFILE_LIST)

all_logs: $(ALL_LOGFILE_LIST)

all_tests: all_logs
	@echo  '*** SUCCESS ***'
