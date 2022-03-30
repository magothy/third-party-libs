#!/bin/bash
set -o

THIS_DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)
SYSTEM_SPECIFIC_DIR="$1"
CONAN_PROFILE="$2"
BUILD_DIR="$SYSTEM_SPECIFIC_DIR/build"

export CONAN_USER_HOME="$SYSTEM_SPECIFIC_DIR" # conan adds a .conan dir after this

mkdir -p "$BUILD_DIR"
pushd "$BUILD_DIR"
conan remote add --force magothy https://jfrog.magothyrt.com/artifactory/api/conan/magothy
conan install "$THIS_DIR" --build missing --profile "$CONAN_PROFILE"
cp -r lib "$SYSTEM_SPECIFIC_DIR"
cp -r include "$THIS_DIR"
popd
