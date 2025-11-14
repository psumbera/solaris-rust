# Oracle Solaris Rustup builder

This builds rustup for Solaris before Solaris is officially supported by
Rustup upstream (https://github.com/rust-lang/rustup).

It requires at least Rust 1.88 to build (it was tested with 1.91.1 [1])

The usage is:

RUST_PATH=~/rust-1.91.1/bin ./build.sh

[1] Rust 1.91.1 for Solaris:
https://static.rust-lang.org/dist/rust-1.91.1-x86_64-pc-solaris.tar.xz
https://static.rust-lang.org/dist/rust-1.91.1-sparcv9-sun-solaris.tar.xz
