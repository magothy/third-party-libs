#!/bin/bash

THIS_DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

/build_base.sh "$THIS_DIR" "$THIS_DIR/profile.txt"
