#!/bin/bash

THIS_DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

apt update -y && apt install -y python3-pip && pip3 install conan

curl -kLO https://github.com/Kitware/CMake/releases/download/v3.23.0-rc5/cmake-3.23.0-rc5-linux-x86_64.tar.gz
tar -xf cmake-3.23.0-rc5-linux-x86_64.tar.gz
export PATH="$PWD/cmake-3.23.0-rc5-linux-x86_64/bin:$PATH"


/build_base.sh "$THIS_DIR" "$THIS_DIR/conan-libstdc++11.txt"
