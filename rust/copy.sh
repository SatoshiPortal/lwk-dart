ROOT="target"
VERSION=$1
NAME="liblwk"
BUILD_DIR=$ROOT/$NAME.$VERSION
# MACOS_DIR="../macos" # final binaries stored here
# IOS_DIR="../ios" # final binaries stored here
FRAMEWORK="liblwk.xcframework"
    
    #    if [ -d "../android/src/main/jniLibs" ]; then rm -r ../android/src/main/jniLibs
    #     fi
        if [ -d "../ios/$FRAMEWORK" ]; then rm -r "../ios/$FRAMEWORK"
        fi
    #     if [ -d "../macos/rust_bdk_ffi.xcframework" ]; then rm -r ../macos/rust_bdk_ffi.xcframework
    #     fi

    #    mkdir -p ../android/src/main/jniLibs/arm64-v8a
    #    mkdir -p ../android/src/main/jniLibs/armeabi-v7a
    #    mkdir -p ../android/src/main/jniLibs/x86
    #    mkdir -p ../android/src/main/jniLibs/x86_86

    #    cp target/aarch64-linux-android/release/librust_bdk_ffi.so  ../android/src/main/jniLibs/arm64-v8a
    #    cp target/armv7-linux-androideabi/release/librust_bdk_ffi.so  ../android/src/main/jniLibs/armeabi-v7a
    #    cp target/i686-linux-android/release/librust_bdk_ffi.so  ../android/src/main/jniLibs/x86
    #    cp target/x86_64-linux-android/release/librust_bdk_ffi.so  ../android/src/main/jniLibs/x86_86
    #    cp -r bdk.0.30.0/rust_bdk_ffi.xcframework ../macos/
    cp -r "$BUILD_DIR/$FRAMEWORK" ../ios/