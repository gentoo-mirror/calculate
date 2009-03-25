# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

inherit kde eutils distutils subversion

if [[ "${PV}" =~ (_p)([0-9]+) ]] ; then
	ESVN_REVISION=${BASH_REMATCH[2]}
fi
ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/extragear/multimedia/k3b"
DESCRIPTION="K3b, KDE CD Writing Software"
HOMEPAGE="http://www.k3b.org/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_compile() {
	cmake -DCMAKE_INSTALL_PREFIX=/usr/ || die "cmake failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
