# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit linux-mod

COMMIT="30626ffd5678c65680e4fff03d8a09642cae36a0"

DESCRIPTION="Realtek 8814AU USB WiFi module for Linux kernel"
HOMEPAGE="https://github.com/aircrack-ng/rtl8814au"
SRC_URI="https://github.com/aircrack-ng/rtl8814au/archive/${COMMIT}.zip -> rtl8814au-${PV}.zip"

LICENSE="GPL-2"
KEYWORDS="~amd64"

DEPEND="virtual/linux-sources
	app-arch/unzip"
RDEPEND=""

S="${WORKDIR}/rtl8814au-${COMMIT}"

MODULE_NAMES="8814au(net/wireless)"
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

