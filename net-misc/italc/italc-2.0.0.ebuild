# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/italc/italc-1.0.9.ebuild,v 1.9 2011/02/28 18:02:57 ssuominen Exp $

EAPI=4

inherit eutils cmake-utils

DESCRIPTION="Intelligent Teaching And Learning with Computers (iTALC) supports working with computers in school"
HOMEPAGE="http://italc.sourceforge.net/"
SRC_URI="mirror://sourceforge/italc/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="X +crypt xinerama"

RDEPEND="dev-libs/lzo
	sys-apps/tcp-wrappers
	virtual/jpeg
	sys-libs/zlib
	dev-libs/openssl
	x11-libs/qt-core
	x11-libs/qt-xmlpatterns
	xinerama? ( x11-libs/libXinerama )
	X? ( x11-libs/libICE
		x11-libs/libSM
		x11-libs/libX11
		x11-libs/libXdamage
		x11-libs/libXext
		x11-libs/libXfixes
		x11-libs/libXrandr
		x11-libs/libXtst
		x11-apps/xinput
		x11-libs/qt-gui:4 )"
DEPEND="${RDEPEND}
	X? ( x11-proto/inputproto )"

DOCS=( TODO README README.LZO AUTHORS INSTALL ChangeLog )

pkg_setup() {
	enewgroup italc
}

src_configure() {
	local mycmakeargs+=(
	    $(cmake-utils_use_enable crypt)
	    $(cmake-utils_use_enable xinerama)
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
#	Install server logo
	newicon ima/resources/window_demo.png ${PN}.png
	make_desktop_entry "${PN}" "iTALC Master" "${PN}" "Qt;KDE;Education"
}

pkg_postinst() {
	elog "On the master, please run "
	elog "# emerge --config =${CATEGORY}/${PF}"

	elog "Please add the logins of master users (teachers) to the italc group by running"
	elog "# usermod -a -G italc <loginname>"

	elog ""
}

pkg_config() {
	if [ ! -d /etc/italc/keys ] ; then
		einfo "Creating public and private keys for italc in /etc/italc/keys."
		/usr/bin/ica -role teacher -createkeypair > /dev/null
		eend $?
		einfo "Setting chmod 640 on private keys."
		chgrp -R italc /etc/italc
		chmod -R o-rwx /etc/italc/keys/private
	else
		einfo "Not creating new keypair, as /etc/italc/keys already exists"
	fi
}
