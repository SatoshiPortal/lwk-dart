#!/bin/bash
VERSION=$1
mkdir -p target/unittest.libboltz.$VERSION
cargo build --release
OS=$(uname -s)
if [ "$OS" = "Linux" ]; then
    cp target/release/liblwkbridge.so target/unittest.libboltz.$VERSION
    cp target/release/liblwkbridge.so ../build/unit_test_assets/lib
elif [ "$OS" = "Darwin" ]; then
    cp target/release/liblwkbridge.dylib target/unittest.libboltz.$VERSION
else
    echo "Unsupported OS: $OS"
    exit 1
fi
