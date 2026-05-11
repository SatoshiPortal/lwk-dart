# Reproducible Binary Checks

This directory contains wrappers for verifying that published Cargokit
precompiled binaries are reproducible from the checked-out Rust sources.

The flow has two separate checks:

1. `verify-binaries` downloads each release asset and verifies its signature.
2. `reproduce-binaries` rebuilds the same target locally, downloads the signed
   release asset, verifies the signature, and compares the local and remote
   bytes.

No private signing key is needed for reproduction. The command uses the public
key and URL prefix from `rust/cargokit.yaml` when the crate has a
`precompiled_binaries` section. If the repository has not committed that
section yet, pass the values with environment variables:

```bash
export CARGOKIT_PRECOMPILED_URL_PREFIX='https://github.com/SatoshiPortal/bdk-flutter/releases/download/precompiled_'
export CARGOKIT_PRECOMPILED_PUBLIC_KEY='<32-byte-ed25519-public-key-hex>'
```

The release tag must be named `precompiled_<crate-hash>`, which is the same
layout produced by Cargokit's `precompile-binaries` command.

## macOS and iOS

Run Apple target checks directly on a macOS host:

```bash
./reproducible_builds/reproduce-darwin.sh
```

Or through make:

```bash
make -f reproducible_builds/makefile darwin
```

Pass explicit targets when you only want part of the Apple matrix:

```bash
./reproducible_builds/reproduce-darwin.sh \
  --target aarch64-apple-darwin \
  --target aarch64-apple-ios
```

## Linux

Run the Linux verifier in Docker:

```bash
./reproducible_builds/reproduce-linux-docker.sh
```

Or through make:

```bash
make -f reproducible_builds/makefile linux
```

By default this checks `x86_64-unknown-linux-gnu` on `linux/amd64`. Override the
platform and target for arm64-capable Docker hosts:

```bash
DOCKER_PLATFORM=linux/arm64 \
RUST_TARGET=aarch64-unknown-linux-gnu \
./reproducible_builds/reproduce-linux-docker.sh
```

## Android

Run the Android verifier in Docker:

```bash
./reproducible_builds/reproduce-android-docker.sh
```

Or through make:

```bash
make -f reproducible_builds/makefile android
```

This checks all Android targets supported by Cargokit:

- `armv7-linux-androideabi`
- `aarch64-linux-android`
- `i686-linux-android`
- `x86_64-linux-android`

## Direct Build Tool Usage

The wrappers call the build tool directly:

```bash
cd cargokit/build_tool
dart run build_tool reproduce-binaries --manifest-dir=../../rust
```

Use `--url-prefix` and `--public-key` to check a release source that is not
declared in `rust/cargokit.yaml`.

## Maintainer Release Checklist

1. Generate a signing keypair:

   ```bash
   cd cargokit/build_tool
   dart run build_tool gen-key
   ```

2. Store the private key in GitHub Actions secrets as
   `CARGOKIT_PRIVATE_KEY`. Do not commit it.

3. Commit the public key and release URL prefix in `rust/cargokit.yaml`:

   ```yaml
   precompiled_binaries:
     url_prefix: https://github.com/SatoshiPortal/lwk-dart/releases/download/precompiled_
     public_key: <32-byte-ed25519-public-key-hex>
   ```

4. Build and upload release artifacts from CI with Cargokit's existing
   `precompile-binaries` command. Android CI needs the Android SDK path, NDK
   version, and minimum SDK arguments. macOS CI builds macOS and iOS targets.

5. From an independent checkout, run the relevant reproducibility checks:

   ```bash
   make -f reproducible_builds/makefile linux
   make -f reproducible_builds/makefile android
   make -f reproducible_builds/makefile darwin
   ```

The verification run should print the crate hash, each target, every checked
artifact name, and a SHA-256 digest for byte-identical artifacts. Any missing
release asset, invalid signature, or byte mismatch exits non-zero.
