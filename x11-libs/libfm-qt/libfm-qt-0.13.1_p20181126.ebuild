# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils eapi7-ver

COMMIT="d0e9e8360f3eb6b7cc952e942f4c715b08d85b16"
DESCRIPTION="Qt port of libfm, a library providing components to build desktop file managers"
HOMEPAGE="https://lxqt.org/"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lxqt/${PN}.git"
else
	SRC_URI="https://github.com/lxqt/libfm-qt/archive/${COMMIT}.zip -> libfm-qt-${PV}.zip"
	KEYWORDS="amd64 ~arm ~arm64 x86"
fi

LICENSE="GPL-2+ LGPL-2.1+"
SLOT="0/6"

RDEPEND="
	dev-libs/glib:2
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	>=lxde-base/menu-cache-1.1.0
	media-libs/libexif:=
	x11-libs/libxcb:=
"
DEPEND="${RDEPEND}
	dev-qt/linguist-tools:5
	>=dev-util/lxqt-build-tools-0.5.0
	virtual/pkgconfig
"

S="${WORKDIR}/${PN}-${COMMIT}"

src_prepare() {
	default_src_prepare
	sed -i '/INSTALL_DIR.*translations/d' src/CMakeLists.txt
}

src_configure() {
	local mycmakeargs=(
		-DPULL_TRANSLATIONS=OFF
	)
	cmake-utils_src_configure
}
