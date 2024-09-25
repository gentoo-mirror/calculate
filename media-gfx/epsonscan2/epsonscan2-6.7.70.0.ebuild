# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_VER="${PV}-1"

DESCRIPTION="Epson scanner management utility"
HOMEPAGE="https://support.epson.net/linux/en/epsonscan2.php"
SRC_URI="https://download3.ebz.epson.net/dsc/f/03/00/16/14/37/7577ee65efdad48ee2d2f38d9eda75418e490552/${PN}-${MY_VER}.src.tar.gz"

S="${WORKDIR}/${PN}-${MY_VER}"

inherit cmake desktop udev

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/boost
	dev-libs/rapidjson
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	media-gfx/sane-backends
	media-libs/libharu
	media-libs/libjpeg-turbo:=
	media-libs/libpng
	media-libs/tiff
	sys-libs/zlib
	virtual/libusb:1
"

RDEPEND="${DEPEND}"

PATCHES="${FILESDIR}/${P}-cmake-and-desktop.patch"

src_prepare() {
	cmake_src_prepare
	rm -rf CMakeCache.txt
	# Force usage of system libraries
	rm -rf thirdparty/{HaruPDF,rapidjson,zlib}
	sed -i \
		-e '/thirdparty\/HaruPDF/d' \
		-e '/thirdparty\/zlib/d' \
		-e 's|^\([[:blank:]]*\)\(usb-1.0\)|\1\2\n\1hpdf\n\1z|' \
		src/Controller/CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
		-DEPSON_INSTALL_ROOT="${EPREFIX}"
		-DCMAKE_CXX_STANDARD=11 )
	cmake_src_configure
}

src_install() {
	cmake_src_install
#	# Desktop icon
	domenu desktop/rpm/x86_64/epsonscan2.desktop
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
