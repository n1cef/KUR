
pkgname=
pkgver=

dependencies=(
	
	
)
sources=(
	""
)

md5sums=(
	''
)


kraken_prepare() {
	
	tar -xvf "${SOURCE_DIR}/${pkgname}/${pkgname}-${pkgver}.tar.xz" -C "${SOURCE_DIR}/${pkgname}" &&

	cd "${SOURCE_DIR}/${pkgname}/${pkgname}-${pkgver}" &&

	
}
kraken_build() {
	cd "${SOURCE_DIR}/${pkgname}/${pkgname}-${pkgver}" &&
	make
}

kraken_test() {
	cd "${SOURCE_DIR}/${pkgname}/${pkgname}-${pkgver}" &&
	
	echo "$pkgname does not come with a test suite nothing to do !"  
    return 0
}

kraken_install() {
	cd "${SOURCE_DIR}/${pkgname}/${pkgname}-${pkgver}" &&
	make install
    return 0
}

kraken_preinstall() {
	cd "${SOURCE_DIR}/${pkgname}/${pkgname}-${pkgver}" &&
	echo "nothing to do !"
	return 0
}

kraken_postinstall() {
	cd "${SOURCE_DIR}/${pkgname}/${pkgname}-${pkgver}" &&
   
	return 0 
}

kraken_preremove() {
	return
}

kraken_remove() {
	
 	
	return 
}

kraken_postremove() {
	return
}

# vim:set ts=4 syntax=sh:
