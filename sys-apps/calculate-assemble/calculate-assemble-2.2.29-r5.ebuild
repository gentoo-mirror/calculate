# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2:2.7"
RESTRICT_PYTHON_ABIS="2.4 2.5 2.6 3.*"

inherit distutils eutils

SRC_URI="ftp://ftp.calculate.ru/pub/calculate/calculate2/${PN}/${P}.tar.bz2"

DESCRIPTION="The utilities for assembling tasks of Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="~sys-apps/calculate-builder-2.2.29"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# resolve install depends
	epatch "${FILESDIR}/calculate-assemble-2.2.29-resolve_install_deps.patch"

	# fix work with 3.0 utilities
	epatch "${FILESDIR}/calculate-assemble-2.2.29-fix_work_with_3.0.patch"

	# fix install git in new stage3
	epatch "${FILESDIR}/calculate-assemble-2.2.29-fix_install_git.patch"

	# add clean portages
	epatch "${FILESDIR}/calculate-assemble-2.2.29-clean.patch"

	# fix fetch video
	epatch "${FILESDIR}/calculate-assemble-2.2.29-fix_novideo.patch"
}
