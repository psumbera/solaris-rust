# Oracle Solaris Rust builder

This project builds latest stable Rust version for Oracle Solaris 11.4 CBE release [1] (currently 11.4.42).

Note that to build Rust version X you need to have version X or X-1 versoin.

Usage example:

```
RUST_BOOTSTRAP=~/.rust_solaris/rustc-1.86.0/bin ./build.sh
```

Ultimately Rust should install in standard manner (rustup). But we are not there yet..

To install Rust pre built binaries on Solaris you can use:
```
source <(curl -s https://raw.githubusercontent.com/psumbera/solaris-rust/refs/heads/main/sh.rust-web-install)
```
For example:
```
$ source <(curl -s https://raw.githubusercontent.com/psumbera/solaris-rust/refs/heads/main/sh.rust-web-install)
Downloading Rust 1.82.0 for Solaris from github. It can take some time...
Rust 1.82.0 was installed into /export/home/test/.rust-solaris.
PATH was modified to: PATH=/export/home/test/.rust-solaris/rustc-1.82.0/bin:$PATH
$
```

Note that `~/.rust-solaris/bin` link should point to Rust bin directory.

[1] https://www.oracle.com/solaris/solaris11/downloads/solaris-downloads.html
