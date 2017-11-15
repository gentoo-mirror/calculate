# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

DEADBEEF_GUI="yes"

inherit deadbeef-plugins

GITHUB_COMMIT="5f4784e8213f1601692e0ee4f908d6f9a0f99db2"

DESCRIPTION="DeaDBeeF waveform seekbar plugin"
HOMEPAGE="https://github.com/cboxdoerfer/ddb_waveform_seekbar"
SRC_URI="https://github.com/cboxdoerfer/ddb_waveform_seekbar/archive/${GITHUB_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

RDEPEND+=" dev-db/sqlite:3"

DEPEND="${RDEPEND}"

S="${WORKDIR}/ddb_waveform_seekbar-${GITHUB_COMMIT}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-cflags-lm.patch"
}

src_compile() {
	use gtk2 && emake gtk2
	use gtk3 && emake gtk3
}
