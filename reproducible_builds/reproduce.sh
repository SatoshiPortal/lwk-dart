#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR/cargokit/build_tool"

args=(reproduce-binaries --manifest-dir=../../rust)

if [[ -n "${CARGOKIT_PRECOMPILED_URL_PREFIX:-}" || -n "${CARGOKIT_PRECOMPILED_PUBLIC_KEY:-}" ]]; then
  if [[ -z "${CARGOKIT_PRECOMPILED_URL_PREFIX:-}" || -z "${CARGOKIT_PRECOMPILED_PUBLIC_KEY:-}" ]]; then
    echo "CARGOKIT_PRECOMPILED_URL_PREFIX and CARGOKIT_PRECOMPILED_PUBLIC_KEY must be set together." >&2
    exit 2
  fi
  args+=(--url-prefix "$CARGOKIT_PRECOMPILED_URL_PREFIX")
  args+=(--public-key "$CARGOKIT_PRECOMPILED_PUBLIC_KEY")
fi

exec dart run build_tool "${args[@]}" "$@"
