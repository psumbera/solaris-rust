#!/bin/bash
#
# Build script for Rust on Solaris.
#
set -xe

VERSION=1.83.0

PATH=$RUST_BOOTSTRAP:/usr/gnu/bin:/usr/bin

CONFIGURE_OPTIONS+=" --default-linker=gcc"
CONFIGURE_OPTIONS+=" --enable-local-rust"
CONFIGURE_OPTIONS+=" --release-channel=stable"

WS="`pwd`"
BUILD_DIR="$WS/build_dir"

SRC_DIR=rustc-${VERSION}-src
SRC_ARCHIVE=${SRC_DIR}.tar.xz

BUILD_HOME="$BUILD_DIR"/rustc-${VERSION}-home
PROTO_DIR="$BUILD_DIR"/rustc-${VERSION}-proto

GCC=/usr/gcc/11/bin/gcc
GXX=/usr/gcc/11/bin/g++

mkdir -p "$BUILD_DIR"

# Clean build directory
( cd "$BUILD_DIR"; rm -rf $SRC_DIR $SRC_ARCHIVE  $BUILD_HOME $PROTO_DIR )

mkdir -p $BUILD_HOME $PROTO_DIR

# Download source archive
( cd "$BUILD_DIR"; wget -q https://static.rust-lang.org/dist/${SRC_ARCHIVE} )

# Unpack source archive
( cd "$BUILD_DIR" ; gtar xf ${SRC_ARCHIVE} )

# Patch sources
( cd "$BUILD_DIR"/${SRC_DIR};
  cat "$WS/patches/series" | while read patch args; do
    echo $patch | grep ^\# > /dev/null && continue
    gpatch --batch --forward --strip=1 $args -i "$WS/patches/$patch"
  done )

# Force cargo to use vendored sources
( cd "$BUILD_HOME"
  mkdir -p .cargo 
  echo "[source.crates-io]" > .cargo/config.toml
  echo "replace-with = \"vendored-sources\"" >> .cargo/config.toml
  echo "[source.vendored-sources]" >> .cargo/config.toml
  echo "directory = \""$BUILD_DIR"/${SRC_DIR}/vendor\"" >> .cargo/config.toml )

cd "$BUILD_DIR"/$SRC_DIR

# Configuration
PATH="$PATH" CC=$GCC CXX=$GXX bash ./configure ${CONFIGURE_OPTIONS} 

# Build Rust
PATH=$PATH PKG_CONFIG_PATH=/usr/lib/64/pkgconfig HOME=$BUILD_HOME gmake install DESTDIR=$PROTO_DIR

# Create Rust distribution archive
( cd $PROTO_DIR/usr && mv local rustc-${VERSION} && gtar cfJ $BUILD_DIR/rust-${VERSION}-Solaris-11.4.42-CBE-`mach`.tar.xz rustc-${VERSION} )
