#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd -- "$script_dir/.." && pwd)"
source_dir="$repo_root/moku"
build_dir="$source_dir/build"

printf '[INFO] Running tests in build directory [%s].\n' "$build_dir"

pushd "$build_dir" >/dev/null
trap 'popd >/dev/null' EXIT

if ctest --output-on-failure; then
    printf '[INFO] Tests completed successfully in [%s].\n' "$build_dir"
else
    status=$?
    printf '[ERROR] Tests failed in [%s] (exit code %s).\n' "$build_dir" "$status" >&2
    exit "$status"
fi