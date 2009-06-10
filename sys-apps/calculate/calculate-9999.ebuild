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
IUSE="nmap"
DEPEND="sys-apps/util-linux
	dev-lang/perl
	sys-apps/grep
	sys-apps/which
	net-misc/wget
	net-dns/bind-tools
	nmap? ( net-analyzer/nmap )
	sys-apps/net-tools
	sys-apps/hal
	sys-apps/findutils
	sys-apps/pciutils
	sys-boot/grub
	sys-fs/udev
	net-nds/openldap
	sys-apps/usbutils
	sys-devel/gettext
	sys-apps/file
	sys-kernel/calckernel
	dev-libs/openssl
	app-arch/tar
	sys-apps/module-init-tools
	app-arch/gzip
	app-arch/bzip2
	app-arch/p7zip
	app-arch/cpio
	app-shells/bash
	app-portage/layman"
RDEPEND="${DEPEND}"

pkg_setup() {
	if [ -e /usr/calculate/install ] && \
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
	ln -sf /usr/calculate/install/calculate /usr/sbin/calculate
}
