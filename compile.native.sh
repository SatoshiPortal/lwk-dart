#!/bin/bash
mkdir -p build/unit_test_assets
cd rust || exit 1
cargo update
cargo build --release --target=aarch64-apple-darwin
OS=$(uname -s)
if [ "$OS" = "Linux" ]; then
    cp target/aarch64-apple-darwin/release/liblwkbridge.so ../build/unit_test_assets
elif [ "$OS" = "Darwin" ]; then
    cp target/aarch64-apple-darwin/release/liblwkbridge.dylib ../build/unit_test_assets
else
    echo "Unsupported OS: $OS"
    exit 1
fi
cd - || exit 1