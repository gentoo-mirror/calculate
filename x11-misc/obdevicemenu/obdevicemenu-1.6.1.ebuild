# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

DESCRIPTION="OpenBox device menu"
HOMEPAGE="http://sourceforge.net/projects/obdevicemenu/"
SRC_URI="http://sourceforge.net/projects/obdevicemenu/files/${PF}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="notifications"

DEPEND="
	app-shells/bash
	sys-apps/dbus
	x11-wm/openbox
	sys-fs/udisks
	notifications? ( x11-misc/notification-daemon )
"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${PF}"

src_unpack() {
    if [ "${A}" != "" ]; then
        unpack ${A}
    fi
}

src_install() {
    insinto /etc
    doins obdevicemenu.conf || die
    exeinto /usr/local/bin
    doexe obdevicemenu || die
}
