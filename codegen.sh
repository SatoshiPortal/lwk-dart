#!/bin/bash
#!/bin/bash
cd rust
cargo update
cd - || exit 1
flutter_rust_bridge_codegen ./flutter_rust_bridge_codegen