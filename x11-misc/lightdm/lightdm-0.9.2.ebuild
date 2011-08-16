# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lightdm/Attic/lightdm-0.2.3.ebuild,v 1.3 2011/04/29 13:52:00 ssuominen dead $

EAPI=4
inherit autotools-utils pam

DESCRIPTION="A lightweight display manager"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/LightDM"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk +introspection qt4 static-libs"

RDEPEND="dev-libs/glib:2
	virtual/pam
	x11-libs/libxklavier
	x11-libs/libX11
	dev-libs/libxml2
	gtk? ( >=x11-libs/gtk+-2 )
	qt4? ( x11-libs/qt-core
		x11-libs/qt-dbus )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext
	introspection? ( dev-libs/gobject-introspection )"

DOCS=( NEWS )

src_prepare() {
	epatch "${FILESDIR}/${P}-gtk.patch"
	autotools-utils_src_prepare
	eautoreconf
}

src_configure() {
	myeconfargs=(
		--localstatedir=/var
		$(use_enable introspection)
		$(use_enable qt4 liblightdm-qt)
		$(use_enable gtk liblightdm-gtk)
		--with-html-dir="${EPREFIX}"/usr/share/doc/${PF}/html
	)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
	rm -Rf "${ED}"/etc/init
	pamd_mimic system-local-login lightdm auth account session
}
