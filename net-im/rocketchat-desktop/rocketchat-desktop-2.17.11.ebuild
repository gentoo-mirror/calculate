# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Desktop application for Rocket.Chat"
HOMEPAGE="https://rocket.chat"

inherit unpacker xdg-utils

MYPN="Rocket.Chat.Electron"

SRC_URI="https://github.com/RocketChat/${MYPN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="amd64"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="+emoji"
REQUIRED_USE=""

RESTRICT="network-sandbox"

RDEPEND="app-accessibility/at-spi2-atk:2
	dev-db/sqlcipher
	dev-libs/atk
	dev-libs/expat
	dev-libs/nspr
	dev-libs/nss
	>=net-libs/nodejs-12.14.0
	net-print/cups
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libxcb
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/libXScrnSaver
	x11-libs/pango
	emoji? ( media-fonts/noto-emoji )"
DEPEND="${RDEPEND}"
BDEPEND="sys-apps/yarn"

QA_PREBUILT="
	/opt/Rocket.Chat/chrome-sandbox
	/opt/Rocket.Chat/rocketchat-desktop
	/opt/Rocket.Chat/libEGL.so
	/opt/Rocket.Chat/libGLESv2.so
	/opt/Rocket.Chat/libffmpeg.so
	/opt/Rocket.Chat/swiftshader/libvk_swiftshader.so
	/opt/Rocket.Chat/swiftshader/libEGL.so
	/opt/Rocket.Chat/swiftshader/libGLESv2.so"

S="${WORKDIR}/$MYPN-${PV}"

src_prepare() {
	default
	sed -i 's,"@babel/preset-env".*,"@babel/preset-env": "^7.7.4"\,,' package.json
	npm install node-gyp || die
	npm install yarn || die
	npm update || die
}

src_compile() {
	PATH="${PATH}:$S/node_modules/.bin" yarn || die
	PATH="${PATH}:$S/node_modules/.bin" NODE_ENV=production yarn gulp build || die
	PATH="${PATH}:$S/node_modules/.bin" NODE_ENV=production yarn electron-builder --linux deb || die
}

src_install() {
	unpack dist/rocketchat_${PV}_amd64.deb
	tar -xvf data.tar.xz || die

	mv usr/share/doc/rocketchat usr/share/doc/${PF} || die
	gunzip usr/share/doc/${PF}/changelog.gz || die

	insinto /
	doins -r usr
	doins -r opt
	local f
	for f in ${QA_PREBUILT}; do
		fperms +x "${f}"
	done
	dosym ../../opt/Rocket.Chat/${PN} /usr/bin/${PN}
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
