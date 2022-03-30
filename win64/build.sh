#!/bin/bash

THIS_DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)
#C:\Users\nknot\AppData\Local\Programs\Python\Python310\Scripts

export PATH="/c/Users/nknot/AppData/Local/Programs/Python/Python310/Scripts:$PATH"

echo $PATH

../build_base.sh "$THIS_DIR" "$THIS_DIR/profile.txt"
