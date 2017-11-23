# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
COMMIT="5f054bec89fa9f69985552b302c24fa68b183bcb"
DESCRIPTION="Http upload plugins for Gajim"

HOMEPAGE="https://dev.gajim.org/gajim/gajim-plugins"
SRC_URI="https://dev.gajim.org/gajim/gajim-plugins/repository/${GIT_COMMIT}/archive.tar.bz2 -> gajim-plugins-${PV}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	net-im/gajim"

S="${WORKDIR}"

src_install() {
	cd gajim-plugins-*-${COMMIT}
	insinto /usr/share/gajim/plugins
	doins -r httpupload
	doins -r image
	doins -r url_image_preview
}
