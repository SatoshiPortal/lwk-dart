#!/bin/bash
ROOT="target"
VERSION=$1
NAME="liblwk"
LIB=$ROOT/$NAME.$VERSION
cd $ROOT
zip -r $NAME.$VERSION.zip $NAME.$VERSION