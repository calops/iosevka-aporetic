#! /usr/bin/env bash
set -eux

nix build .#aporetic-sans .#aporetic-sans-mono -L

DIST="$(realpath "${1:-$PWD/dist}")"
mkdir -p "$DIST"

pushd ./result
zip -9 -r "$DIST/aporetic-sans.zip" ./.
popd

pushd ./result-1
zip -9 -r "$DIST/aporetic-sans-mono.zip" ./.
popd
