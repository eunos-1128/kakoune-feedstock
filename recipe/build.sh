#!/bin/bash

set -exo pipefail

if [[ "${target_platform}" == "linux-"* ]]; then
    make install -j${CPU_COUNT} \
        debug=no \
        PREFIX=${PREFIX} \
        CXX=${CXX}

elif [[ "${target_platform}" == "osx-"* ]]; then
    make install -j${CPU_COUNT} \
        debug=no \
        PREFIX=${PREFIX} \
        CXX=$(command -v clang++) \
        LDFLAGS="${LDFLAGS} -stdlib=libc++ -lc++abi" \
        CXXFLAGS="${CXXFLAGS} -stdlib=libc++" \
        CPPFLAGS-os-Darwin="-I${BUILD_PREFIX}/include" \
        LDFLAGS-os-Darwin="-L${BUILD_PREFIX}/lib"
fi
