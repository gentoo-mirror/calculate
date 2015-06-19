# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
#
EAPI=5

PLOCALES="en es"
PLOCALE_BACKUP="en"

inherit l10n qt4-r2

DESCRIPTION="YouTube Browser for SMPlayer"
HOMEPAGE="http://smplayer.sourceforge.net/smtube"
SRC_URI="mirror://sourceforge/smplayer/${P}.tar.bz2"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2+"
SLOT="0"
IUSE=""

DEPEND="dev-qt/qtcore:4
	dev-qt/qtgui:4"
RDEPEND="${DEPEND}
	|| ( media-video/mpv media-video/smplayer media-video/mplayer media-video/vlc kde-base/dragon media-video/totem media-video/gnome-mplayer )"

src_prepare() {
	eqmake4 src/${PN}.pro
}

gen_translation() {
	lrelease ${PN}_${1}.ts
	eend $? || die "failed to generate $1 translation"
}

src_compile() {
	emake

	cd "${S}"/src/translations
	l10n_for_each_locale_do gen_translation
}

install_locale() {
	insinto /usr/share/${PN}/translations
	doins "${S}"/src/translations/${PN}_${1}.qm
	eend $? || die "failed to install $1 translation"
}

src_install() {
	dobin ${PN}
	domenu ${PN}.desktop
	newicon icons/${PN}_64.png ${PN}.png
	dodoc Changelog

	l10n_for_each_locale_do install_locale
}
