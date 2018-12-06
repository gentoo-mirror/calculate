# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils eapi7-ver xdg-utils

COMMIT="b93da36d2c6c183495e493a5a8763b56ab2408a8"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lxqt/${PN}.git"
else
	SRC_URI="https://github.com/lxqt/pcmanfm-qt/archive/${COMMIT}.zip -> pcmanfn-qt-${PV}.zip"
	KEYWORDS="amd64 ~arm ~arm64 x86"
fi

DESCRIPTION="Fast lightweight tabbed filemanager (Qt port)"
HOMEPAGE="https://lxqt.org/"

LICENSE="GPL-2+ LGPL-2.1+"
SLOT="0"

S="${WORKDIR}/${PN}-${COMMIT}"

RDEPEND="
	dev-libs/glib:2
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	>=x11-libs/libfm-1.2.0:=
	~x11-libs/libfm-qt-0.13.1_p20181126
	x11-libs/libxcb:=
	x11-misc/xdg-utils
	virtual/eject
	virtual/freedesktop-icon-theme
	!lxqt-base/lxqt-common
"
DEPEND="${RDEPEND}
	dev-qt/linguist-tools:5
	>=dev-util/lxqt-build-tools-0.5.0
"

src_prepare() {
	default_src_prepare
	sed -i '/INSTALL_DIR.*translations/d' pcmanfm/CMakeLists.txt
}

src_configure() {
	local mycmakeargs=(
		-DPULL_TRANSLATIONS=OFF
	)
	cmake-utils_src_configure
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
