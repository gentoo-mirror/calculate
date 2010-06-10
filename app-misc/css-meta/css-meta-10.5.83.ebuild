# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit calculate

DESCRIPTION="Calculate Scratch Server (meta package)"
HOMEPAGE="http://www.calculate-linux.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="kernel"

RDEPEND="kernel? ( sys-kernel/calculate-sources )
	app-misc/livecd-tools
	app-portage/eix
	app-portage/layman
	dev-vcs/git
	media-fonts/terminus-font
	net-misc/dhcp
	sys-apps/calculate
	sys-apps/openrc
	sys-boot/calcboot
	sys-boot/grub
	sys-fs/reiserfsprogs
	sys-kernel/calckernel
"

pkg_postinst() {
	calculate_change_version

	local calculatename=$( get_value calculate < ${CALCULATE_INI} )
	local system=$( get_value system < ${CALCULATE_INI} )

	[[ "$calculatename" == "CSS" ]] &&
	[[ -n "$(eselect profile show |
		grep calculate/${system}/${calculatename}/${ARCH}/developer)" ]] && 
		eselect profile set calculate/${system}/${calculatename}/${ARCH}
}
