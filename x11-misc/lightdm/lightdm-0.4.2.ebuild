# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lightdm/Attic/lightdm-0.2.3.ebuild,v 1.3 2011/04/29 13:52:00 ssuominen dead $

EAPI=4
inherit pam

DESCRIPTION="A lightweight display manager"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/LightDM"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+introspection qt4"

RDEPEND="dev-libs/glib:2
	virtual/pam
	x11-libs/libxcb
	x11-libs/libXdmcp
	x11-libs/libxklavier
	x11-libs/libX11
	qt4? ( x11-libs/qt-core
		x11-libs/qt-dbus )"
DEPEND="${RDEPEND}
	dev-lang/vala:0.12
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext
	introspection? ( dev-libs/gobject-introspection )"

DOCS=( NEWS )

src_configure() {
	local default=gnome
	has_version xfce-base/xfce4-meta && default=xfce

	VALAC="$(type -p valac-0.12)" \
	econf \
		--localstatedir=/var \
		--disable-static \
		$(use_enable introspection) \
		$(use_enable qt4 liblightdm-qt) \
		--with-default-xsession=${default} \
		--with-html-dir="${EPREFIX}"/usr/share/doc/${PF}/html
}

src_install() {
	default
	find "${ED}" -name '*.la' -exec rm -f {} +
	rm -Rf "${ED}"/etc/init
	pamd_mimic system-local-login lightdm auth account session
}
