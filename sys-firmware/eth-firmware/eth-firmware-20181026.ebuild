# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MYPN=linux-firmware
MYP=linux-firmware-${PV}

GIT_COMMIT="1cb4e51018293c14642f115b5868cda92b879161"

DESCRIPTION="Binary firmware for Realtek Ethernet"
HOMEPAGE="https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git"
SRC_URI="https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/snapshot/linux-firmware-${GIT_COMMIT}.tar.gz -> ${MYP}.tar.gz"

LICENSE="linux-firmware ( BSD ISC MIT no-source-code ) GPL-2 GPL-2+ freedist"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="!sys-kernel/linux-firmware"

RESTRICT="binchecks strip"

src_unpack() {
	default
	# rename directory from git snapshot tarball
	mv ${MYPN}-*/ ${P} || die
}

src_install() {
	insinto /lib/firmware/
	doins -r rtl_nic
}
