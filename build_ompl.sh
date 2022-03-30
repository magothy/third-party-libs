#!/bin/bash

THIS_DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)
COPY_DIR="$THIS_DIR" # where final output is copied to

WORKING_DIR="$THIS_DIR/build"
INSTALL_DIR="$WORKING_DIR/install" # where libraries are installed to via make install

EIGEN_INSTALL_DIR="$INSTALL_DIR/eigen"
BOOST_INSTALL_DIR="$INSTALL_DIR/boost"
OMPL_INSTALL_DIR="$INSTALL_DIR/ompl"

mkdir -p "$WORKING_DIR"
mkdir -p "$INSTALL_DIR"

pushd "$WORKING_DIR"

## Compile Eigen
git clone https://gitlab.com/libeigen/eigen.git
git -C eigen checkout "3.3.7"
mkdir eigen_build
pushd eigen_build
cmake "../eigen" -DBUILD_TESTING=OFF -DCMAKE_INSTALL_PREFIX="$EIGEN_INSTALL_DIR"
make install
popd

## Compile Boost
#curl -kOL https://boostorg.jfrog.io/artifactory/main/release/1.78.0/source/boost_1_78_0.tar.gz
#tar -xf boost_1_78_0.tar.gz
pushd boost_1_78_0
#./bootstrap.sh
./b2 --prefix="$BOOST_INSTALL_DIR" --with-serialization --with-filesystem --with-system --with-program_options cxxflags="-std=c++17" install
popd

## Compile OMPL
git clone git@bitbucket.org:magothyrivertechnologies/ompl.git
git -C ompl checkout disable-dubins-asserts
mkdir ompl_build
pushd ompl_build
cmake ../ompl \
    -DCMAKE_MODULE_PATH="$BOOST_INSTALL_DIR/lib/cmake" \
    -DCMAKE_PREFIX_PATH="$BOOST_INSTALL_DIR;$EIGEN_INSTALL_DIR" \
    -DCMAKE_INSTALL_PREFIX="$OMPL_INSTALL_DIR"
make -j8 install
popd

popd

rm -fr "$COPY_DIR/lib" "$COPY_DIR/include" "$COPY_DIR/share" 
mkdir -p "$COPY_DIR/lib"
cp -r "$OMPL_INSTALL_DIR/include" "$COPY_DIR"
cp -L "$OMPL_INSTALL_DIR/lib/libompl.dylib" "$COPY_DIR/lib"
cp -L "$BOOST_INSTALL_DIR/lib/libboost_atomic.dylib" "$COPY_DIR/lib"
cp -L "$BOOST_INSTALL_DIR/lib/libboost_filesystem.dylib" "$COPY_DIR/lib"
cp -L "$BOOST_INSTALL_DIR/lib/libboost_serialization.dylib" "$COPY_DIR/lib"

#install_name_tool -id "@executable_path/$GDAL_LIB" "$COPY_DIR/lib/$GDAL_LIB"
