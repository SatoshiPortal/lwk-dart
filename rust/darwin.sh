#!/bin/bash
CORES=8
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
IOS_LIPO=$IOS_LIPO_DIR/$LIBNAME

if [ -d "$IOS_LIPO_DIR" ]; then rm -r $IOS_LIPO_DIR
fi
if [ -d "$BUILD_DIR/$FRAMEWORK" ]; then rm -r $BUILD_DIR/$FRAMEWORK
fi

mkdir -p $IOS_LIPO_DIR $MAC_LIPO_DIR

# Build static libs
for TARGET in \
    aarch64-apple-ios \
    x86_64-apple-ios \
    aarch64-apple-ios-sim
do
    echo "Building for $TARGET..."
    rustup target add $TARGET
    cargo build --release --target=$TARGET || { echo "Build failed for $TARGET"; exit 1; }
done

echo "Creating universal binary for simulators..."
cargo install cargo-lipo
cargo lipo --release --targets x86_64-apple-ios,aarch64-apple-ios-sim || { echo "Lipo failed for simulators"; exit 1; }

mkdir -p $IOS_LIPO_DIR
cp target/universal/release/$LIBNAME $IOS_LIPO

# Create XCFramework zip
lipo -create -output $IOS_LIPO \
    target/aarch64-apple-ios-sim/release/$LIBNAME \
    target/x86_64-apple-ios/release/$LIBNAME

echo "Creating XCFramework..."
xcodebuild -create-xcframework \
    -library $IOS_LIPO \
    -library target/aarch64-apple-ios/release/$LIBNAME \
    -output $BUILD_DIR/$FRAMEWORK || { echo "XCFramework creation failed"; exit 1; }

rm -rf $IOS_LIPO_DIR 