#!/bin/bash
#!/bin/bash
cd rust
cargo update
cd - || exit 1
cargo install 'flutter_rust_bridge_codegen@^2.0.0-dev.31'
flutter_rust_bridge_codegen generate