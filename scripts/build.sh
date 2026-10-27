#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd -- "$script_dir/.." && pwd)"
source_dir="$repo_root/moku"
build_dir="$source_dir/build"

if cmake -S "$source_dir" -B "$build_dir" -DCMAKE_BUILD_TYPE=Release; then
    :
else
    status=$?
    printf '[ERROR] CMake configuration failed for [%s] (exit code %s).\n' \
        "$build_dir" "$status" >&2
    exit "$status"
fi

printf '[INFO] CMake configuration was successful.\n'
printf '[INFO] Starting build process.\n'

if cmake --build "$build_dir" --config Release; then
    :
else
    status=$?
    printf '[ERROR] Build failed in [%s] (exit code %s).\n' "$build_dir" "$status" >&2
    exit "$status"
fi

printf '[INFO] Build completed successfully in [%s].\n' "$build_dir"