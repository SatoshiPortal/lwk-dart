!#/bin/bash

ROOT="target"
VERSION=$1
NAME="liblwk"
# LIB=$ROOT/$NAME.$VERSION
cd $ROOT || exit 1
zip -r $NAME.$VERSION.zip $NAME.$VERSION
zip -r unittest.$NAME.$VERSION.zip $NAME.$VERSION
cd - || exit 1