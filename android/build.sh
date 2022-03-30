#!/bin/bash

docker run -v ${PWD}:/scripts \
           -v ${PWD}/../build_base.sh:/build_base.sh \
           -v ${PWD}/../conanfile.txt:/conanfile.txt \
           --rm -it \
           conanio/android-clang8-armv7 \
           /scripts/build_docker.sh
