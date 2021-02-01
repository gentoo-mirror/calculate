# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

PYTHON_COMPAT=(python2_7)
DISTUTILS_USE_SETUPTOOLS=manual
inherit distutils2 eutils python2

DESCRIPTION="A simple library for writing soap web services."
HOMEPAGE="http://wiki.github.com/jkp/soaplib"
SRC_URI="https://github.com/${PN}/${PN}/tarball/${P} -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RDEPEND="
	dev-python/lxml-python2
	dev-python/pytz-python2
"
DEPEND="${RDEPEND}
	dev-python/setuptools-python2
"

S="${WORKDIR}/soaplib-soaplib-2801978"

python_install_all() {
	distutils2_python_install_all

	rm -rf "${ED}$(python_get_sitedir)/tests/"

	if use examples ; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*.py || die "doins failed"
	fi
}
