#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
IMAGE_NAME="${IMAGE_NAME:-bdk-flutter-repro-android}"
DOCKER_PLATFORM="${DOCKER_PLATFORM:-linux/amd64}"
ANDROID_NDK_VERSION="${ANDROID_NDK_VERSION:-26.3.11579264}"
ANDROID_MIN_SDK_VERSION="${ANDROID_MIN_SDK_VERSION:-23}"

docker build \
  --platform "$DOCKER_PLATFORM" \
  --build-arg ANDROID_NDK_VERSION="$ANDROID_NDK_VERSION" \
  -f "$ROOT_DIR/reproducible_builds/Dockerfile.android" \
  -t "$IMAGE_NAME" \
  "$ROOT_DIR"

docker run --rm \
  --platform "$DOCKER_PLATFORM" \
  -e CARGOKIT_PRECOMPILED_URL_PREFIX="${CARGOKIT_PRECOMPILED_URL_PREFIX:-}" \
  -e CARGOKIT_PRECOMPILED_PUBLIC_KEY="${CARGOKIT_PRECOMPILED_PUBLIC_KEY:-}" \
  -v "$ROOT_DIR:/work" \
  -w /work \
  "$IMAGE_NAME" \
  ./reproducible_builds/reproduce.sh \
    --android-sdk-location=/opt/android-sdk \
    --android-ndk-version="$ANDROID_NDK_VERSION" \
    --android-min-sdk-version="$ANDROID_MIN_SDK_VERSION" \
    --target armv7-linux-androideabi \
    --target aarch64-linux-android \
    --target i686-linux-android \
    --target x86_64-linux-android \
    "$@"
