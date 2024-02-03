#!/bin/bash
cd lwk-dart || exit 1
bash linux.sh "$VERSION"
exec "$@"