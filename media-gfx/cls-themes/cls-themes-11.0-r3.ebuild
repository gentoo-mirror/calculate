# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit calculate

DESCRIPTION="The theme for Calculate Linux Scratch"
HOMEPAGE="http://www.calculate-linux.org/cls-themes"
SRC_URI="ftp://ftp.calculate.ru/pub/calculate/${PN}/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="!media-gfx/calculate-cls-themes
		media-gfx/splashutils
		>=sys-apps/calculate-templates-2.2.1-r5"

DEPEND="${RDEPEND}"

src_install() {
		insinto /
		doins -r .
}

pkg_postinst() {
	local initrdfile=$(calculate_get_current_initrd)
	local initrdinstallfile=$(calculate_get_current_initrd -install)
	[[ -f ${ROOT}${initrdfile} ]] &&
		calculate_update_splash ${ROOT}${initrdfile}
	[[ -f ${ROOT}${initrdinstallfile} &&
		"${ROOT}${initrdinstallfile}" != "${ROOT}${initrdfile}" ]] &&
		calculate_update_splash ${ROOT}${initrdinstallfile}
}
