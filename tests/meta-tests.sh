#!/bin/sh

bin/rapid-scheme -Ishare -Irapid-lib -Irapid-read -Irapid-expansion -Ilib bin/rapid-compiler.scm > tests/rapid-compiler.bin

chibi-scheme -Irapid-lib -Ilib tests/rapid-compiler.bin -Ishare -Irapid-lib -Irapid-read -Irapid-expansion -Ilib bin/rapid-compiler.scm > tests/rapid-compiler.out

diff tests/rapid-compiler.bin tests/rapid-compiler.out
