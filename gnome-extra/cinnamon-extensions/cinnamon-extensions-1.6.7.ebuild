# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-shell-frippery/gnome-shell-frippery-0.3.6.ebuild,v 1.2 2012/01/12 19:18:10 tetromino Exp $

EAPI="4"

inherit eutils

DESCRIPTION="Extension pack for cinnamon"
HOMEPAGE="http://www.calculate-linux.org"
SRC_URI="ftp://ftp.calculate.ru/pub/calculate/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=gnome-extra/cinnamon-${PV}"
DEPEND=""

#S="${WORKDIR}/.local/share/gnome-shell"

src_install() {
	insinto /usr/share/cinnamon/extensions
	doins -r extensions/*
	insinto /usr/share/themes
	doins -r themes/Calculate
	insinto /usr/share/cinnamon/applets
	doins -r applets/*
}
