# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit distutils

SRC_URI="ftp://ftp.calculate.ru/pub/calculate/calculate2/${PN}/${P}.tar.bz2"

DESCRIPTION="The library for Calculate 2"
HOMEPAGE="http://www.calculate-linux.org/Calculate2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
DEPEND="!<sys-apps/calculate-client-2.1.8
		!<sys-apps/calculate-server-2.1.6
		>=dev-lang/python-2.5.2
		>=dev-python/python-ldap-2.0[ssl]
		>=dev-python/pyxml-0.8"
RDEPEND="${DEPEND}"
