.SUFFIXES:

SHELL = /bin/bash
LIBRARY_PATHS = -Ischeme-lib -Ischeme-reader -Ischeme-expander -Ilib
SCHEME = chibi-scheme $(LIBRARY_PATHS)
TEST = tests/test-runner.sh

UNIT_TESTS = scheme-lib/tests.scm scheme-reader/tests.scm scheme-expander/tests.scm

all:

check: all $(UNIT_TESTS) check_r7rs

$(UNIT_TESTS): all
	$(SCHEME) $@

check_r7rs: all
	$(TEST) tests/r7rs-tests.scm

check_meta: all
	tests/meta-tests.sh

.PHONY: all check check_r7rs check_meta $(UNIT_TESTS)
