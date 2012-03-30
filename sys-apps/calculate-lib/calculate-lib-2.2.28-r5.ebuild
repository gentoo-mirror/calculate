# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit distutils eutils

SRC_URI="ftp://ftp.calculate.ru/pub/calculate/calculate2/${PN}/${P}.tar.bz2"

DESCRIPTION="The library for Calculate 2"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="2.2"
KEYWORDS="amd64 x86"
IUSE="minimal"
DEPEND="!<sys-apps/calculate-lib-2.1.8-r1
	!=sys-apps/calculate-lib-2.1.9
	!=sys-apps/calculate-lib-2.1.10
	!minimal? ( dev-python/py-smbpasswd )
	>=dev-python/pyxml-0.8
	sys-apps/iproute2
	sys-apps/pciutils
	sys-fs/lvm2
	sys-fs/mdadm
	sys-apps/file[python]"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# fix autoupdate user profile
	epatch "${FILESDIR}/calculate-lib-2.2.28-fix_update.patch"
	# fix ati name
	epatch "${FILESDIR}/calculate-lib-2.2.28-fix_ati_name.patch"
	# fix detect video by /etc/X11/xorg.conf
	epatch "${FILESDIR}/calculate-lib-2.2.28-fix_detect_video.patch"
	# fix detect ability gzip for squashfs-tools
	epatch "${FILESDIR}/calculate-lib-2.2.28-fix_detect_compress.patch"
	# fix detect util path and ifconfig
	epatch "${FILESDIR}/calculate-lib-2.2.28-fix_ifconfig.patch"
}
