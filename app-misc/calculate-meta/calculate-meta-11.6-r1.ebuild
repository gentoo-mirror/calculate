# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit calculate
EAPI=2

DESCRIPTION="Calculate Linux (meta package)"
HOMEPAGE="http://www.calculate-linux.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="
cdistro_CLD
cdistro_CLDG
cdistro_CLDX
cdistro_CMC
cdistro_CLS
cdistro_CDS
cdistro_CSS
"

RDEPEND="${RDEPEND}
	!sys-apps/calculate
"

RDEPEND="${RDEPEND}
	cdistro_CLD? ( app-misc/cld-meta )
	cdistro_CLDG? ( app-misc/cldg-meta )
	cdistro_CLDX? ( app-misc/cldx-meta )
	cdistro_CMC? ( app-misc/cmc-meta )
	cdistro_CLS? ( app-misc/cls-meta )
	cdistro_CDS? ( app-misc/cds-meta )
	cdistro_CSS? ( app-misc/css-meta )
"

pkg_postinst() {
	if [[
		-z `grep cl_merges /etc/calculate/calculate2.env` &&
		! -z `grep cl_merges /etc/config-archive/etc/calculate/calculate2.env`
	]];
	then
		mv /etc/config-archive/etc/calculate/calculate2.env \
		/etc/calculate/calculate2.env
		rm /etc/config-archive/etc/calculate/calculate2.env.dist
		ewarn "Restored file /etc/calculate/calculate2.env."
	fi

	if [[ -e /etc/calculate/._cfg0000_calculate2.env ]];
	then
		rm /etc/calculate/._cfg0000_calculate2.env
	fi

	if [[ ! -e /etc/env.d/02locale ]];
	then
		eerror "Please restore the system settings by running 'cl-install --live'!"
	fi
}

