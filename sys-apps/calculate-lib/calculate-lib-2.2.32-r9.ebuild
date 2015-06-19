# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=(python2_7)

inherit distutils-r1 eutils

SRC_URI="ftp://ftp.calculate.ru/pub/calculate/calculate2/${PN}/${P}.tar.bz2
	http://mirror.yandex.ru/calculate/calculate2/${PN}/${P}.tar.bz2"

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

	# create revision for calculate lib
	epatch "${FILESDIR}/calculate-lib-2.2.32-r2.patch"

	# fix for compabitble with file-5.19
	epatch "${FILESDIR}/calculate-lib-2.2.32-fix_file.patch"

	# fix for clean kernel from builder
	epatch "${FILESDIR}/calculate-lib-2.2.32-fix_clean_kernel.patch"

	# fix lock ini file
	epatch "${FILESDIR}/calculate-lib-2.2.32-fix_lock_ini.patch"

	# fix work with lz4 initramfs
	epatch "${FILESDIR}/calculate-lib-2.2.32-fix_lz4.patch"

	# fix copy xattr
	epatch "${FILESDIR}/calculate-lib-2.2.32-copy_xattr.patch"

	# support skip templates 3.3
	epatch "${FILESDIR}/calculate-lib-2.2.32-fix_template3.patch"
}
