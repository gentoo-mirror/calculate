# Copyright 1999-2010 Gentoo Foundation
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
	!x11-plugins/pidgin-facebookchat
	!app-text/goldendict
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
	calculate_change_version

	local calculatename=$( detect_linux_shortname )
	local system=desktop
	if [[ $calculatename == "CDS" ]] || [[ $calculatename == "CSS" ]]
	then
		system=server
	fi

	# check version on stable (PV hasn't 999)
	if ! [[ "$PV" =~ 999 ]] && [[ -e /proc/self/mountinfo ]] && \
		[[ -e /proc/1/mountinfo ]] && \
		diff /proc/self/mountinfo /proc/1/mountinfo &>/dev/null
	then
		[[ -n "$calculatename" ]] &&
		[[ "$calculatename" != "CMC" ]] &&
		[[ "$calculatename" != "CLS" ]] &&
		[[ "$calculatename" != "CSS" ]] &&
		[[ -n "$(eselect profile show |
			grep calculate/${system}/${calculatename}/${ARCH})" ]] && 
			eselect profile set calculate/${system}/${calculatename}/${ARCH}/binary
	fi
}

