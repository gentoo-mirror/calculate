# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit linux-info linux-mod

COMMIT="7b7fc22beaa54d3a0676da345e8a1ac943557463"

DESCRIPTION="Realtek RTL8723DE module for Linux kernel"
HOMEPAGE="https://github.com/smlinux/rtl8723de"
SRC_URI="https://github.com/smlinux/rtl8723de/archive/${COMMIT}.tar.gz -> rtl8723de-${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64"

DEPEND="virtual/linux-sources"
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
