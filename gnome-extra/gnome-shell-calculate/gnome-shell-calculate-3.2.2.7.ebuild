# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-shell-frippery/gnome-shell-frippery-0.3.6.ebuild,v 1.2 2012/01/12 19:18:10 tetromino Exp $

EAPI="4"

DESCRIPTION="Extension pack Calculate-like features for GNOME 3"
HOMEPAGE="http://www.calculate-linux.org"
SRC_URI="ftp://ftp.calculate.ru/pub/calculate/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-admin/eselect-gnome-shell-extensions
	gnome-extra/gnome-shell-extensions
	gnome-extra/gnome-shell-frippery"
DEPEND=""

#S="${WORKDIR}/.local/share/gnome-shell"

src_install() {
	insinto /usr/share/gnome-shell/extensions
	doins -r extensions/*
	insinto /usr/share/themes
	doins -r themes/Calculate
}

pkg_postinst() {
	ebegin "Updating list of installed extensions"
	eselect gnome-shell-extensions update
	eend $?
}
