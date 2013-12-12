# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2:2.7"
RESTRICT_PYTHON_ABIS="2.4 2.5 2.6 3.*"

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

	# create UEFI hybrid iso images
	epatch "${FILESDIR}/calculate-lib-2.2.31-iso_UEFI.patch"

	# fix work file magic on samba big files (kernel 3.7.7)
	epatch "${FILESDIR}/calculate-lib-2.2.31-file_magic.patch"

	# fix work version
	epatch "${FILESDIR}/calculate-lib-2.2.31-fix_ver.patch"

	# fix work with file 5.15
	epatch "${FILESDIR}/calculate-lib-2.2.31-file_magic2.patch"
}
