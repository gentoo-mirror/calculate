# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=(python2_7)

declare -A CALCULATE_MODULES=(
	["update"]="3.4.1.1"
	["builder"]="3.4.1.1"
	["console-gui"]="3.4.1.1"
)

inherit calculate-utils

DESCRIPTION="A set of Calculate utilities for system installation, build and upgrade"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate_utilities"

LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS="amd64 x86"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# fix prepare
	epatch "${FILESDIR}/calculate-builder-3.4.1.1-fix_prepare.patch"

	if use desktop
	then
		# fix sync faces
		epatch "${FILESDIR}/calculate-desktop-3.4.1.1-fix_faces_sync.patch"
	fi
}
