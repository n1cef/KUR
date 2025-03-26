# 🚀 Kraken Package Build Repository


## 🚀 Purpose
This repository contains `pkgbuild.kraken` files used by the **Kraken package manager** to build software packages from source. These build recipes are designed for a source-based Linux distribution targeting scientific/research workloads.

## 🚀 Structure Format
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
## 🚀 Example `pkgbuild.kraken` File

```bash
# Metadata
pkgname=gcc
pkgver=14.2.0

# Build dependencies
dependencies=(
)

# Source files
sources=(
    "https://ftp.gnu.org/gnu/gcc/gcc-14.2.0/gcc-14.2.0.tar.xz"
    "https://ftp.gnu.org/gnu/mpfr/mpfr-4.2.1.tar.xz"
    "https://ftp.gnu.org/gnu/gmp/gmp-6.3.0.tar.xz"
    "https://ftp.gnu.org/gnu/mpc/mpc-1.3.1.tar.gz"
)

# Verification hashes
md5sums=(
    '2268420ba02dc01821960e274711bde0'
    '523c50c6318dde6f9dc523bc0244690a'
    '956dc04e864001a9c22429f761f2c283'
    '5c9bc658c9fd0f940e8e3e0f09530c62'
)

# Build phases
kraken_prepare() {
    tar -xvf "${SOURCE_DIR}/${pkgname}/${pkgname}-${pkgver}.tar.xz" -C "${SOURCE_DIR}/${pkgname}"
    cd "${SOURCE_DIR}/${pkgname}/${pkgname}-${pkgver}"
    
    # Extract dependencies
    tar -xf ../mpfr-4.2.1.tar.xz && mv -v mpfr-4.2.1 mpfr
    tar -xf ../gmp-6.3.0.tar.xz && mv -v gmp-6.3.0 gmp
    tar -xf ../mpc-1.3.1.tar.gz && mv -v mpc-1.3.1 mpc
    
    # Architecture-specific patches
    case $(uname -m) in
        x86_64)
            sed -e '/m64=/s/lib64/lib/' \
                -i.orig gcc/config/i386/t-linux64
            ;;
    esac
    
    # Configure build
    mkdir -v build
    cd build
    ../configure \
        --target=$KRAKEN_TGT \
        --prefix=$KRAKEN/tools \
        --with-glibc-version=2.41 \
        --with-sysroot=$KRAKEN \
        --with-newlib \
        --without-headers \
        --enable-default-pie \
        --enable-default-ssp \
        --disable-nls \
        --disable-shared \
        --disable-multilib \
        --disable-threads \
        --disable-libatomic \
        --disable-libgomp \
        --disable-libquadmath \
        --disable-libssp \
        --disable-libvtv \
        --disable-libstdcxx \
        --enable-languages=c,c++
}

kraken_build() {
    cd "${SOURCE_DIR}/${pkgname}/${pkgname}-${pkgver}/build"
    make
}

kraken_test() {
    echo "$pkgname does not come with a test suite - nothing to do!"
    return 0
}

kraken_install() {
    cd "${SOURCE_DIR}/${pkgname}/${pkgname}-${pkgver}/build"
    sudo make install
    return 0
}

# Optional lifecycle hooks
kraken_preinstall() { return 0; }
kraken_postinstall() { return 0; }
kraken_preremove() { return 0; }

kraken_remove() {
 cd "${SOURCE_DIR}/${pkgname}/${pkgname}-${pkgver}/build"
 make uninstall;
 return 0;
}
kraken_postremove() { return 0; }


```

##  📂 Related Projects
   <h3> [Kraken Package Manager](https://github.com/n1cef/kraken_package_manager) </h3>
