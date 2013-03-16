# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit versionator autotools

MY_P="${P/_/~}"

DESCRIPTION="A light and easy to use libvte based X Terminal Emulator"
HOMEPAGE="http://lilyterm.luna.com.tw"
SRC_URI="${HOMEPAGE}/file/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug nls safe-mode"

RDEPEND="dev-libs/glib:2
	x11-libs/gtk+:2
	x11-libs/vte:0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

DOCS=( AUTHORS ChangeLog README TODO data/lilyterm.conf )

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -e '/DOCDIR/d' -i "${S}"/data/Makefile || die "sed0 failed"
	sed -e '/EXAMPLES_DIR/d' -i "${S}"/data/Makefile || die "sed1 failed"
	sed -e 's/xpm \\$//' -i  "${S}"/data/Makefile || die "sed2 failed"
}

src_configure() {
	local myconf="--prefix=/usr --sysconfdir=/etc/xdg"
	use debug && myconf+=" --enable-debug"
	use nls || myconf+=" --disable-nls"
	use safe-mode || myconf+=" --disable-safe-mode"
	einfo "Doing ./configure \"${myconf}\""
	eval "./configure ${myconf}"
}
