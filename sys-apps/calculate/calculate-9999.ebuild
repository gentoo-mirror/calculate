# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mtop/mtop-0.6.6.ebuild,v 1.9 2007/07/13 06:38:59 mr_bones_ Exp $

inherit subversion

ESVN_REPO_URI="http://svn.calculate.ru/calculate/trunk/"
DESCRIPTION="Program for installation, building and upgrading system"
HOMEPAGE="http://www.calculate-linux.org/Calculate"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=""
RDEPEND="${DEPEND}"

pkg_setup() {
	if [ -e /usr/calculate/install ] && \
		[ `ls /usr/calculate/install | grep -c ""` -gt 0  ] && \
		! [ -e /var/db/pkg/sys-apps/calculate-[0-9]* ];
	then
		eerror "Finding other copy of calculate in target directory"
		eerror "Please, remove it, before continue installation."
		eerror "\trm -rf /usr/calculate/install"
		die "Cannot continue install. Remove previous calculate installation."
	fi
}

src_install() {
	emake install DESTDIR="${D}" || die "Calculate installation failed."
	dodoc Change.log COPYING LICENSE
}

pkg_postinst() {
	if ! [ -e /usr/calculate/share/addition ];
	then
		mkdir -p /usr/calculate/share/addition
	fi
	if ! [ -e /usr/calculate/share/linux ];
	then
		mkdir -p /usr/calculate/share/linux
	fi
	if ! [ -e /usr/calculate/share/distfiles ];
	then
		mkdir -p -m 2775 /usr/calculate/share/distfiles	
		chgrp portage /usr/calculate/share/distfiles	
	fi
}
