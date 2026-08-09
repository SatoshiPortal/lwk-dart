#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
IMAGE_NAME="${IMAGE_NAME:-bdk-flutter-repro-linux}"
DOCKER_PLATFORM="${DOCKER_PLATFORM:-linux/amd64}"
RUST_TARGET="${RUST_TARGET:-x86_64-unknown-linux-gnu}"

docker build \
  --platform "$DOCKER_PLATFORM" \
  -f "$ROOT_DIR/reproducible_builds/Dockerfile.linux" \
  -t "$IMAGE_NAME" \
  "$ROOT_DIR"

docker run --rm \
  --platform "$DOCKER_PLATFORM" \
  -e CARGOKIT_PRECOMPILED_URL_PREFIX="${CARGOKIT_PRECOMPILED_URL_PREFIX:-}" \
  -e CARGOKIT_PRECOMPILED_PUBLIC_KEY="${CARGOKIT_PRECOMPILED_PUBLIC_KEY:-}" \
  -v "$ROOT_DIR:/work" \
  -w /work \
  "$IMAGE_NAME" \
  ./reproducible_builds/reproduce.sh --target "$RUST_TARGET" "$@"
