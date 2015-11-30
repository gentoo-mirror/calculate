# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

PYTHON_COMPAT=(python2_7)
inherit distutils-r1 eutils python-r1

DESCRIPTION="A simple library for writing soap web services."
HOMEPAGE="http://wiki.github.com/jkp/soaplib"
SRC_URI="https://github.com/${PN}/${PN}/tarball/${P} -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RDEPEND="
	dev-python/lxml
	dev-python/pytz
"
DEPEND="${RDEPEND}
	dev-python/setuptools
"

S="${WORKDIR}/soaplib-soaplib-2801978"

python_install_all() {
	distutils-r1_python_install_all

	rm -rf "${ED}$(python_get_sitedir)/tests/"

	if use examples ; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*.py || die "doins failed"
	fi
}
