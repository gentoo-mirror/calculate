# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

DEADBEEF_GUI="yes"

inherit autotools deadbeef-plugins git-r3

GITLAB_COMMIT="47bc3fe0fe151dfbb75f90f9e4d5e9a7affd280a"
EGIT_COMMIT="${EGIT_COMMIT}"

DESCRIPTION="DeaDBeeF filebrowser plugin"
HOMEPAGE="https://gitlab.com/zykure/deadbeef-fb"
#SRC_URI="https://gitlab.com/zykure/deadbeef-fb/repository/archive.tar.gz?ref=${PV/*_p/} -> ${P}.tar.gz"
EGIT_REPO_URI="https://gitlab.com/zykure/deadbeef-fb.git"


LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

IUSE+=" debug"

RDEPEND+=" !media-plugins/deadbeef-librarybrowser:0"

DEPEND="${RDEPEND}"

src_prepare() {
    epatch "${FILESDIR}/${PN}-new-avoid-version.patch"
	eautoreconf
}

src_configure() {
	econf --disable-static \
		$(use_enable debug) \
		$(use_enable gtk2) \
		$(use_enable gtk3)
}
