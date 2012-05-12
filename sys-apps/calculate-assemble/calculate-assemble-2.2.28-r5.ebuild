# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit distutils eutils

SRC_URI="ftp://ftp.calculate.ru/pub/calculate/calculate2/${PN}/${P}.tar.bz2"

DESCRIPTION="The utilities for assembling tasks of Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="~sys-apps/calculate-builder-2.2.28"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# add python updater executing
	epatch "${FILESDIR}/calculate-assemble-2.2.28-python_updater.patch"

	# add downgrade checking
	epatch "${FILESDIR}/calculate-assemble-2.2.28-downgrade_check.patch"

	# add --with-bdeps to emerge world
	epatch "${FILESDIR}/calculate-assemble-2.2.28-update_world_bdeps.patch"

	# add installation python2.7 and set it as default
	epatch "${FILESDIR}/calculate-assemble-2.2.28-python2.7_install.patch"
}
