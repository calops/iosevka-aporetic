#! /usr/bin/env bash
set -eux

outputs=$(nix build .#aporetic-sans .#aporetic-sans-mono --print-out-paths -L)

DIST="$(realpath "${1:-$PWD/dist}")"
mkdir -p "$DIST"

# pushd ./result
# zip -9 -r "$DIST/aporetic-sans.zip" ./.
# popd
#
# pushd ./result-1
# zip -9 -r "$DIST/aporetic-sans-mono.zip" ./.
# popd

while read -r output; do
	pname=$(echo "$output" | sed -E 's#.*/[^-]*-(.*)-.*#\1#')
	pushd "$output"
	zip -9 -r "$DIST/${pname}.zip" ./.
	popd
done <<<"$outputs"
