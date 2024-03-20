# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Papirus icon theme for LibreOffice"
HOMEPAGE="https://git.io/papirus-libreoffice-theme"
if [[ ${PV} == 99999999 ]];then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="https://github.com/PapirusDevelopmentTeam/${PN}.git"
else
	SRC_URI="https://github.com/PapirusDevelopmentTeam/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND="${DEPEND}
	|| (
		app-office/libreoffice
		app-office/libreoffice-bin
	)
"

src_install(){
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr/$(get_libdir)" install
}
