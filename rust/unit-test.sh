#!/bin/bash
VERSION=$1
mkdir -p target/unittest.liblwk.$VERSION
cargo build --release
OS=$(uname -s)
if [ "$OS" = "Linux" ]; then
    cp target/release/liblwkbridge.so target/unittest.liblwk.$VERSION
elif [ "$OS" = "Darwin" ]; then
    cp target/release/liblwkbridge.dylib target/unittest.liblwk.$VERSION
else
    echo "Unsupported OS: $OS"
    exit 1
fi
