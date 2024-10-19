# Copyright 2007-2024 Mir Calculate
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN=linux-firmware
MY_P=linux-firmware-${PV}

GIT_COMMIT="1cb4e51018293c14642f115b5868cda92b879161"

DESCRIPTION="Binary firmware for Realtek Ethernet"
HOMEPAGE="https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git"
SRC_URI="https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/snapshot/linux-firmware-${GIT_COMMIT}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="linux-firmware ( BSD ISC MIT no-source-code ) GPL-2 GPL-2+ freedist"
SLOT="0"
KEYWORDS="amd64"
RESTRICT="binchecks strip"

RDEPEND="!sys-kernel/linux-firmware"

src_unpack() {
	default

	# rename directory from git snapshot tarball
	mv ${MY_PN}-*/ ${P} || die
}

src_install() {
	insinto /lib/firmware/
	doins -r rtl_nic
}
