.SUFFIXES:

SHELL = /bin/bash
LIBRARY_PATHS = -Irapid-lib -Irapid-read -Irapid-expansion -Ilib
SCHEME = chibi-scheme $(LIBRARY_PATHS)

UNIT_TESTS = rapid-lib/tests.scm rapid-read/tests.scm rapid-expansion/tests.scm

all:

check: all $(UNIT_TESTS) check_meta

$(UNIT_TESTS): all
	$(SCHEME) $@

check_meta: all
	tests/meta-tests.sh

.PHONY: all check
