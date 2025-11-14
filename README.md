# Oracle Solaris Rust builder

NOTE that latest Rust versions for Solaris can be now downloaded directly from Rust upstream (https://forge.rust-lang.org/infra/other-installation-methods.html).

Therefore this project no longer builds newer Rustc version (last version was 1.88.0).

This project will be archived after rustup upstream (https://github.com/rust-lang/rustup) starts to support Solaris (hopefully with next version).

For now it's possible to use Rustup binaries for Solaris provided here (see rustup/ directory):

```
curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/psumbera/rustup/refs/heads/solaris-rustup/rustup-init.sh | sh
```

--

This project builds latest stable Rust version for Oracle Solaris 11.4 CBE release [1] (currently 11.4.81).

Note that to build Rust version X you need to have version X or X-1 versoin.

Usage example:

```
RUST_BOOTSTRAP=~/.rust_solaris/rustc-1.87.0/bin ./build.sh
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
