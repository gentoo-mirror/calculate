# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Matrix group messaging app"
HOMEPAGE="https://wiki.gnome.org/Apps/Fractal"

inherit meson xdg-utils

if [[ ${PV} == "9999" ]]; then
	inherit git-r3

	SRC_URI=""
	EGIT_REPO_URI="https://gitlab.gnome.org/world/fractal.git"
	EGIT_BRANCH="master"
else
	SRC_URI="https://gitlab.gnome.org/GNOME/${PN}/-/archive/${PV}/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND=">=virtual/rust-1.31.1
	>=app-text/gspell-1.8.1
	>=x11-libs/cairo-1.16.0
	x11-libs/gtksourceview
	dev-libs/libhandy"
DEPEND="${RDEPEND}"
BDEPEND="dev-util/ninja
	dev-util/meson"
