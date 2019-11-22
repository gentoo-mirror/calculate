# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit linux-mod

COMMIT="27f98a55cc48b9a26e6eb4127976c8feb95867d8"

DESCRIPTION="Realtek RTL8821CE Driver module for Linux kernel"
HOMEPAGE="https://github.com/tomaspinho/rtl8821ce"
SRC_URI="https://codeload.github.com/tomaspinho/rtl8821ce/zip/${COMMIT} -> rtl8821c-${PV}.zip"

LICENSE="GPL-2"
KEYWORDS="amd64 x86"

DEPEND="virtual/linux-sources"
RDEPEND=""

S="${WORKDIR}/rtl8821ce-${COMMIT}"

MODULE_NAMES="8821ce(net/wireless)"
BUILD_TARGETS="all"
BUILD_TARGET_ARCH="${ARCH}"

src_unpack() {
	unpack "${A}"
	cd "${S}"
}

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KERN_DIR=${KV_DIR} KSRC=${KV_DIR} KERN_VER=${KV_FULL} O=${KV_OUT_DIR} V=1 KBUILD_VERBOSE=1"
}

src_compile(){
	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install
}

pkg_postinst() {
	linux-mod_pkg_postinst
}

