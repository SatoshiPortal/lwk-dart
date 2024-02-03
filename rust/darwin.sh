#!/bin/bash

# Setup
ROOT="target"
VERSION=$1
NAME="liblwk"
BUILD_DIR=$ROOT/$NAME.$VERSION
# MACOS_DIR="../macos" # final binaries stored here
# IOS_DIR="../ios" # final binaries stored here
FRAMEWORK="liblwk.xcframework"
LIBNAME=liblwkbridge.a

IOS_LIPO_DIR=$BUILD_DIR/ios-sim-lipo
MAC_LIPO_DIR=$BUILD_DIR/mac-lipo
IOS_LIPO=$IOS_LIPO_DIR/$LIBNAME
MAC_LIPO=$MAC_LIPO_DIR/$LIBNAME

if [ -d "$IOS_LIPO_DIR" ]; then rm -r $IOS_LIPO_DIR
fi
if [ -d "$MAC_LIPO_DIR" ]; then rm -r $MAC_LIPO_DIR
fi
if [ -d "$BUILD_DIR/$FRAMEWORK" ]; then rm -r $BUILD_DIR/$FRAMEWORK
fi

mkdir -p $IOS_LIPO_DIR $MAC_LIPO_DIR

# Build static libs
for TARGET in \
    aarch64-apple-ios \
    x86_64-apple-ios \
    aarch64-apple-ios-sim \
    x86_64-apple-darwin \
    aarch64-apple-darwin
do
    rustup target add $TARGET
    cargo build -r --target=$TARGET
done

cargo install cargo-lipo
# Create XCFramework zip
lipo -create -output $IOS_LIPO \
        target/aarch64-apple-ios-sim/release/$LIBNAME \
        target/x86_64-apple-ios/release/$LIBNAME
lipo -create -output $MAC_LIPO \
        target/aarch64-apple-darwin/release/$LIBNAME \
        target/x86_64-apple-darwin/release/$LIBNAME

xcodebuild -create-xcframework \
        -library $IOS_LIPO \
        -library $MAC_LIPO \
        -library target/aarch64-apple-ios/release/$LIBNAME \
        -output $BUILD_DIR/$FRAMEWORK

rm -rf $IOS_LIPO_DIR $MAC_LIPO_DIR