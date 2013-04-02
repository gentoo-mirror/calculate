# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

PYTHON_DEPEND="2:2.6"
PYTHON_USE_WITH="sqlite"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.[45] 3.* *-jython"

inherit distutils eutils fdo-mime

DESCRIPTION="A hierarchical note taking application"
HOMEPAGE="http://www.giuspen.com/cherrytree/"
SRC_URI="http://www.giuspen.com/software/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/libX11
	>=dev-python/pygtk-2.12:2
	dev-python/pygtksourceview"
DEPEND="${RDEPEND}
	sys-devel/gettext
	"

src_prepare() {
	# Avoid sandbox violation 
	sed -e "s:subprocess.call(\"update-desktop-database\"):#subprocess.call(\"update-desktop-database\"):g" \
		-i setup.py || die "sed failed to patch install.py"

	distutils_src_prepare
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}

