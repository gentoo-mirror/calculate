# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit distutils eutils

SRC_URI="ftp://ftp.calculate.ru/pub/calculate/calculate2/${PN}/${P}.tar.bz2"

DESCRIPTION="The utilities for builder tasks of Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="~sys-apps/calculate-install-2.2.12
	~sys-apps/calculate-templates-2.2.12
	!<sys-apps/calculate-1.4.0_p20100921
	app-cdr/cdrkit
	sys-fs/squashfs-tools"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# fix bug in show variables
	epatch "${FILESDIR}/calculate-builder-2.2.12-show_vars_fix.patch"
	# fix use own config
	epatch "${FILESDIR}/calculate-builder-2.2.12-fix_use_own_config.patch"
	# fix get builder path with corrupt calculate2.env
	epatch "${FILESDIR}/calculate-builder-2.2.12-fix_get_builderpath.patch"
}
