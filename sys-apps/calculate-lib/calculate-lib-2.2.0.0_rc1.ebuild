# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit distutils

SNAPSHOT="052d9566a9c0663e8615e6b8f4c5a2f6522adf62"

SRC_URI="http://git.calculate.ru/?p=${PN}.git;a=snapshot;h=${SNAPSHOT};sf=tgz
	-> ${P}.tar.gz"
DESCRIPTION="The library for Calculate 2"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="2.2"
KEYWORDS="~amd64 ~x86"
IUSE=""
S="${WORKDIR}/${PN}"

DEPEND=">=dev-python/python-ldap-2.0[ssl]
		>=dev-python/pyxml-0.8"
RDEPEND="${DEPEND}"
