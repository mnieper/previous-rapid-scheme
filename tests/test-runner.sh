#!/bin/sh

BASEDIR=$(dirname $0)/..

OUTPUT=`$BASEDIR/bin/scheme $1`
if [ -n "$OUTPUT" ]; then
    echo "$OUTPUT"
    exit 1
fi
