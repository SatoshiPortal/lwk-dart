#!/usr/bin/env bash
set -euo pipefail

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "Apple target reproduction must run on macOS." >&2
  exit 2
fi

"$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/reproduce.sh" "$@"
