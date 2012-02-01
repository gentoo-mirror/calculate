# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit distutils eutils

SRC_URI="ftp://ftp.calculate.ru/pub/calculate/calculate2/${PN}/${P}.tar.bz2"

DESCRIPTION="The utilities for builder tasks of Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND=">=sys-kernel/calckernel-3.4.18
	~sys-apps/calculate-install-2.2.27
	!<sys-apps/calculate-1.4.0_p20100921
	app-cdr/cdrkit
	sys-fs/squashfs-tools"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# fix rescratch, change update portage
	epatch "${FILESDIR}/calculate-builder-2.2.27-r4.patch"
	# fix remove --notree
	epatch "${FILESDIR}/calculate-builder-2.2.27-fix_notree.patch"
	# fix branch rename
	epatch "${FILESDIR}/calculate-builder-2.2.27-fix_branch_rename.patch"
	# change branch for non binary distros
	epatch "${FILESDIR}/calculate-builder-2.2.27-master_branch.patch"
}
