#!/bin/bash

docker run -v ${PWD}:/scripts \
           -v ${PWD}/../build_base.sh:/build_base.sh \
           -v ${PWD}/../conanfile.txt:/conanfile.txt \
           --rm -it \
           mavlink/qgc-build-linux \
           /scripts/build_docker.sh
