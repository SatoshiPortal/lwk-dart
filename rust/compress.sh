#!/bin/bash
ROOT="target"
VERSION=$1
NAME="liblwk"
LIB=$ROOT/$NAME.$VERSION

zip -r $LIB.zip $LIB