# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit git-2

EGIT_REPO_URI="git://git.calculate.ru/calculate.git"
DESCRIPTION="Program for installation, building and upgrading system"
HOMEPAGE="http://www.calculate-linux.org/main/ru/calculate"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""
DEPEND="app-arch/p7zip
	app-cdr/cdrkit
	app-portage/layman
	sys-apps/bar
	sys-apps/hal
	sys-boot/grub
	sys-fs/dosfstools
	sys-fs/squashfs-tools"
RDEPEND="${DEPEND}"

need_repair_manconf=0

pkg_setup() {
	[ -e /var/db/pkg/sys-apps/calculate-1.2.7* ] && need_repair_manconf=1
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
	dodoc Change.log
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
	[[ $need_repair_manconf -eq 1 ]] && \
		sed -ri 's#/usr/bin/python.*manrc \| ##' /etc/man.conf
}
