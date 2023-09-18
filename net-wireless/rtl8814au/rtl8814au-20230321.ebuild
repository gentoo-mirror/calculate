# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit linux-mod-r1

COMMIT="6f80699e68fd2a9f2bba3f1a56ca06d1b7992bd8"

DESCRIPTION="Realtek 8814AU USB WiFi module for Linux kernel"
HOMEPAGE="https://github.com/morrownr/8814au"
SRC_URI="https://github.com/morrownr/8814au/archive/${COMMIT}.tar.gz -> rtl8814au-${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64"
SLOT="0"

DEPEND="virtual/linux-sources"

S="${WORKDIR}/8814au-${COMMIT}"

MODULE_NAMES="8814au(net/wireless)"
BUILD_TARGETS="all"
BUILD_TARGET_ARCH="${ARCH}"

pkg_setup() {
	linux-mod-r1_pkg_setup
	BUILD_PARAMS="KERN_DIR=${KV_DIR} KSRC=${KV_DIR} KERN_VER=${KV_FULL} O=${KV_OUT_DIR} V=1 KBUILD_VERBOSE=1"
}
