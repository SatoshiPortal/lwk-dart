#!/bin/bash
#export PKG_CONFIG_ALLOW_CROSS=1
cd rust || exit 1
make all 
cd .. || exit 1
