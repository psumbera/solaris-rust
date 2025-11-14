#!/bin/bash
#
# Build script for rustup  on Solaris.
#
set -xe

VERSION=20251114

PATH=$RUST_PATH:/usr/gnu/bin:/usr/bin

WS="`pwd`"
BUILD_DIR="$WS/build_dir"

SRC_DIR=rustup-src

SRU=$(uname -v | cut -d . -f 3)
if [ $SRU -ge 78 ]; then
  GCC=/usr/gcc/14/bin/gcc
  GXX=/usr/gcc/14/bin/g++
else
  GCC=/usr/gcc/11/bin/gcc
  GXX=/usr/gcc/11/bin/g++
fi

mkdir -p "$BUILD_DIR"

# Clean build directory
( cd "$BUILD_DIR"; rm -rf $SRC_DIR $BUILD_HOME )

# Clone rustup repo
( cd "$BUILD_DIR"; git clone https://github.com/rust-lang/rustup.git $SRC_DIR )

# Check out tested working version
( cd "$BUILD_DIR/$SRC_DIR" ; git checkout 7444818d076d05438a15422d9ebe97d062527d5b )

cd "$BUILD_DIR"/$SRC_DIR

# Build rustup
PATH="$PATH" CC=$GCC CXX=$GXX cargo build --release

# Rename and list rustup init binary
OPENSSL_VERSION=`elfdump -d target/release/rustup-init | grep libssl | gsed 's;^.*so\.;;'`
mv target/release/rustup-init target/release/rustup-init-$VERSION-`mach`-openssl$OPENSSL_VERSION
ls -lh `pwd`/target/release/rustup-init-$VERSION-`mach`-openssl$OPENSSL_VERSION
