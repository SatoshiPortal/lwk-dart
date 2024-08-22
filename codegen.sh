#!/bin/bash

read -r -p "Do you want to set CPATH? (y/N): " response

# Convert response to lowercase to handle Y or y
response=$(echo "$response" | tr '[:upper:]' '[:lower:]')

if [[ "$response" == "y" ]]; then
    export CPATH="$(clang -v 2>&1 | grep "Selected GCC installation" | rev | cut -d' ' -f1 | rev)/include"
else
    echo "Continuing without setting CPATH."
fi

cd rust
cargo update
cd - || exit 1

flutter_rust_bridge_codegen generate