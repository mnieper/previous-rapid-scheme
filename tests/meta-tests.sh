#!/bin/sh

bin/rapid-scheme -Ishare -Ischeme-lib -Ischeme-reader -Ischeme-expander -Ilib bin/rapid-compiler.scm > tests/rapid-compiler.bin

chibi-scheme -Ischeme-lib -Ilib tests/rapid-compiler.bin -Ishare -Ischeme-lib -Ischeme-reader -Ischeme-expander -Ilib bin/rapid-compiler.scm > tests/rapid-compiler.out

diff tests/rapid-compiler.bin tests/rapid-compiler.out
