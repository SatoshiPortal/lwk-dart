#!/bin/bash
ROOT="target"
VERSION=$1
JNI="liblwk"
UNIT_TEST="unittest.liblwk"
# LIB=$ROOT/$NAME.$VERSION
cd "$ROOT"
zip -r $JNI.$VERSION.zip $JNI.$VERSION
zip -r $UNIT_TEST.$VERSION.zip $UNIT_TEST.$VERSION