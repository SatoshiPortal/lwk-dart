#!/bin/bash
ROOT="target"
VERSION=$1
NAME="liblwk"
LINUX_DIR=$ROOT/$NAME.$VERSION/linux # final binaries stored here
# aarch64-unknown-linux-gnu \
# arm-unknown-linux-gnueabi \
# armv7-unknown-linux-gnueabi \
# i686-unknown-linux-gnu \

for TARGET in \
    x86_64-unknown-linux-gnu 
    # aarch64-unknown-linux-gnu install using docker image amd-64/rust:slim-bullseye requires aarch64-linux-gnu-gcc

do
    rustup target add $TARGET
    cargo build --release --target=$TARGET
done

mkdir -p $LINUX_DIR/x86_64
cp $ROOT/x86_64-unknown-linux-gnu/release/liblwkbridge.so $LINUX_DIR/x86_64/