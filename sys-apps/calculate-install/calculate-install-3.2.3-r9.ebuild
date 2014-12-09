# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=(python2_7)

inherit distutils-r1 eutils

SRC_URI="ftp://ftp.calculate.ru/pub/calculate/calculate3/${PN}/${P}.tar.bz2
	http://mirror.yandex.ru/calculate/calculate3/${PN}/${P}.tar.bz2"

DESCRIPTION="The program of installation Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS="x86 amd64"
IUSE="pxe minimal"

DEPEND="~sys-apps/calculate-core-3.2.3
	!<sys-apps/calculate-install-2.2.29
	app-portage/layman
	>=virtual/udev-197
	!app-misc/livecd-tools
	sys-apps/iproute2[-minimal]
	!minimal? ( sys-boot/grub
	sys-apps/gptfdisk
	>=sys-apps/util-linux-2.19.1
	sys-fs/dosfstools
	sys-fs/squashfs-tools
	sys-block/parted )
	pxe? ( sys-apps/calculate-server
	net-ftp/tftp-hpa
	net-misc/dhcp
	net-fs/nfs-utils )"

src_unpack() {
    unpack "${A}"
    cd "${S}"

    # apply revision changes
    epatch "${FILESDIR}/calculate-install-3.2.3-r9.patch"
}
