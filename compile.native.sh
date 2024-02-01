#!/bin/bash
cd rust || exit 1
cargo update
cargo build
OS=$(uname -s)
if [ "$OS" = "Linux" ]; then
    cp target/debug/liblwk_dart.so ../test/
elif [ "$OS" = "Darwin" ]; then
    cp target/debug/liblwk_dart.dylib ../test/
else
    echo "Unsupported OS: $OS"
    exit 1
fi
cd - || exit 1

./codegen.sh