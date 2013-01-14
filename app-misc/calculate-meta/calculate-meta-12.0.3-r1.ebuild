# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit calculate

DESCRIPTION="Calculate Linux (meta package)"
HOMEPAGE="http://www.calculate-linux.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="${RDEPEND}
	!sys-apps/calculate
"

RDEPEND="${RDEPEND}
	sys-apps/calculate-utilities
"

pkg_postinst()
{
	SETUP_SYSTEM_CMD=/usr/sbin/cl-setup-system
	if [[ -x $SETUP_SYSTEM_CMD ]]
	then
		[[ `$SETUP_SYSTEM_CMD --variable cl_chroot_status` == "off" ]] && \
			$SETUP_SYSTEM_CMD --no-progress
	fi
	true
}
