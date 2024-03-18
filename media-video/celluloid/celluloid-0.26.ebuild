# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson xdg

DESCRIPTION="A simple GTK4 frontend for mpv"
HOMEPAGE="https://celluloid-player.github.io/"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://github.com/celluloid-player/celluloid/releases/download/v${PV}/${P}.tar.xz"
	KEYWORDS="~amd64 ~arm64 ~ppc64"
else
	EGIT_REPO_URI="https://github.com/celluloid-player/celluloid.git"
	inherit git-r3
fi

LICENSE="GPL-3+"
SLOT="0"

RDEPEND=">=dev-libs/glib-2.66
	>=gui-libs/gtk-4.6.1:4
	>=gui-libs/libadwaita-1.2.0
	>=media-video/mpv-0.32:=[libmpv]
	media-libs/libepoxy"
DEPEND="${RDEPEND}"
BDEPEND="dev-libs/appstream-glib
	dev-util/gdbus-codegen
	dev-util/glib-utils
	>=sys-devel/gettext-0.19.8
	virtual/pkgconfig"

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
