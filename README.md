# Kraken Package Build Repository


## Purpose
This repository contains `pkgbuild.kraken` files used by the **Kraken package manager** to build software packages from source. These build recipes are designed for a source-based Linux distribution targeting scientific/research workloads.

## Structure Format
Each package is defined by a `pkgbuild.kraken` file following this template:

```bash
# Basic metadata
pkgname=<package-name>
pkgver=<version>

# Build dependencies
dependencies=(
    "dep1"
    "dep2"
)

# Source archives
sources=(
    "https://example.com/source.tar.xz"
)

# Integrity checks
md5sums=(
    'checksum1'
    'checksum2'
)

# Build phases (functions)
kraken_prepare() { ... }
kraken_build() { ... }
kraken_test() { ... }
kraken_install() { ... }
kraken_preinstall() { ... }
kraken_postinstall() { ... }
kraken_remove() { ... }
kraken_postremove() { ... }
```
