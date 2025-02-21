#! /usr/bin/env bash
set -eux

export NIX_CONFIG="allow-import-from-derivation = true"

nix build .#aporetic-sans -L

DIST="$(realpath "${1:-$PWD/dist}")"
mkdir -p "$DIST"

pushd ./result
zip -9 -r "$DIST/aporetic-sans.zip" ./.
popd
