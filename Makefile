.SUFFIXES:

SHELL = /bin/bash
LIBRARY_PATHS = -Ischeme-lib -Ischeme-reader -Ischeme-expander -Ilib
SCHEME = chibi-scheme $(LIBRARY_PATHS)

UNIT_TESTS = scheme-lib/tests.scm scheme-reader/tests.scm scheme-expander/tests.scm

all:

check: all $(UNIT_TESTS) check_meta

$(UNIT_TESTS): all
	$(SCHEME) $@

check_meta: all
	tests/meta-tests.sh

.PHONY: all check
