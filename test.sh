#!/bin/bash
# Tests for the prek snap.

set -e -o pipefail

echo -e "::group::\e[32mBASIC\e[0m: CLI smoke tests"
prek --version
prek --help >/dev/null
prek cache dir >/dev/null
echo -e "::endgroup::"

tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT

cd "$tmpdir"
git init -q

echo -e "::group::\e[32mBASIC\e[0m: Config and validation"
prek sample-config .pre-commit-config.yaml
test -s .pre-commit-config.yaml
prek validate-config .pre-commit-config.yaml
echo -e "::endgroup::"
