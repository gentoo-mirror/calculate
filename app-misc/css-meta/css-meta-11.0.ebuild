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
KEYWORDS="x86 amd64"
IUSE=""

RDEPEND="
	app-misc/cl-base-meta
"

# Network
RDEPEND="${RDEPEND}
	net-misc/dhcp
"

pkg_postinst() {
	calculate_change_version

	local calculatename=$( get_value calculate < ${CALCULATE_INI} )
	local system=$( get_value system < ${CALCULATE_INI} )

	# check version on stable (PV has only 2 digit)
	if ! [[ "$PV" =~ ^[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+ ]]
	then
		[[ "$calculatename" == "CSS" ]] &&
		[[ -n "$(eselect profile show |
			grep calculate/${system}/${calculatename}/${ARCH}/developer)" ]] && 
			eselect profile set calculate/${system}/${calculatename}/${ARCH}
	fi
}
