# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mtop/mtop-0.6.6.ebuild,v 1.9 2007/07/13 06:38:59 mr_bones_ Exp $

DESCRIPTION="Program for installation, building and upgrading system"
HOMEPAGE="http://www.calculate-linux.org/Calculate"
SRC_URI="ftp://ftp.calculate.ru/pub/calculate/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""
DEPEND="app-arch/bzip2
	app-arch/cpio
	app-arch/gzip
	app-arch/p7zip
	app-arch/tar
	app-portage/layman
	app-shells/bash
	dev-lang/perl
	dev-libs/openssl
	app-cdr/cdrkit
	net-misc/wget
	sys-apps/file
	sys-apps/findutils
	sys-apps/grep
	sys-apps/hal
	sys-apps/module-init-tools
	sys-apps/net-tools
	sys-apps/pciutils
	sys-apps/usbutils
	sys-apps/util-linux
	sys-apps/which
	sys-boot/grub
	sys-devel/gettext
	sys-fs/udev
	sys-kernel/calckernel"
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
