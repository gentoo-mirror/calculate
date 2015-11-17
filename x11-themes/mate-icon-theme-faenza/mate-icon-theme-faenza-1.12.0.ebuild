# Copyright open-overlay 2015 by Alex

EAPI="5"

inherit gnome2 versionator

MATE_BRANCH="$(get_version_component_range 1-2)"

SRC_URI="http://pub.mate-desktop.org/releases/${MATE_BRANCH}/${P}.tar.xz"
DESCRIPTION="Faenza icon theme, that was adapted for MATE desktop"
HOMEPAGE="http://mate-desktop.org"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="minimal"

RDEPEND="!minimal? ( >=x11-themes/mate-icon-theme-1.12:0 )
	x11-themes/hicolor-icon-theme:0"

RESTRICT="binchecks strip"

src_prepare() {
        autoreconf -fi 
	# Remove broken libreoffice icons (dangling symlinks).
	rm matefaenza/apps/16/*libreoffice* || die
}
