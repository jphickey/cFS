# At a minimum the variable O must be set by the caller
ifeq ($(O),)
$(error O must be set prior to native-test.mk)
endif

include common-test.mk

TEST_PARALLEL_JOBS ?= 8
ARCH ?= native

OBJDIR   := $(O)/$(ARCH)

# Check for dirs which have a "CTestTestfile.cmake" - this means we can run ctest there
TEST_TARGETS := $(addsuffix ctest.log,$(dir $(wildcard $(OBJDIR)/*/CTestTestfile.cmake)))

.PHONY: all_tests all_lcov clean_lcov force

all_logs: | clean_lcov

$(OBJDIR)/coverage_test.info: force
	lcov --capture --rc lcov_branch_coverage=1 --exclude '/usr/*' --directory "$(OBJDIR)" --output-file "$(OBJDIR)/coverage_test.info"

clean_lcov:
	find "$(OBJDIR)" -type f -name '*.gcno' -o -name '*.gcda' -print0 | xargs -0 rm -f
	-rm -f $(OBJDIR)/coverage_test.info

%.log: %
	cd $(dir $(*)) && ./$(notdir $(*)) > $(notdir $(*).logtmp)
	@mv -v $(*).logtmp $(@)

%.check: %.log
	touch $(@)

all_lcov: $(OBJDIR)/coverage_test.info
	genhtml "$(OBJDIR)/coverage_test.info" --branch-coverage --output-directory "$(OBJDIR)/lcov"
	@/bin/echo -e "\n\nCoverage Report Link: file://$(abspath $(OBJDIR))/lcov/index.html\n"
