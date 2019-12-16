# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit linux-info linux-mod

COMMIT="0009232fe3b88546a41da4468cdef6de640adf57"

DESCRIPTION="Realtek RTL8723DE module for Linux kernel"
HOMEPAGE="https://github.com/smlinux/rtl8723de"
SRC_URI="https://github.com/smlinux/rtl8723de/archive/${COMMIT}.zip -> rtl8723de-${PV}.zip"

LICENSE="GPL-2"
KEYWORDS="amd64 x86"

DEPEND="virtual/linux-sources
	app-arch/unzip"
RDEPEND=""

S="${WORKDIR}/rtl8723de-${COMMIT}"

MODULE_NAMES="8723de(net/wireless)"
BUILD_TARGETS="all"
BUILD_TARGET_ARCH="${ARCH}"

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# fix work with calculate.env
	epatch "${FILESDIR}/rtl-lower_log.patch"
}

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KERN_DIR=${KV_DIR} KSRC=${KV_DIR} KERN_VER=${KV_FULL} O=${KV_OUT_DIR} V=1 KBUILD_VERBOSE=1"
}
