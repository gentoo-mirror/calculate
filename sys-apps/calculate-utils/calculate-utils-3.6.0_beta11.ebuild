# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=(python2_7)

UTILS_PV="3.6.0_beta1"


declare -A CALCULATE_MODULES=(
	["lib"]="3.6.0_beta8"
	["install"]="3.6.0_beta5"
	["core"]="3.6.0_beta3"
	["i18n"]="3.6.0_beta4"
	["update"]="3.6.0_beta13"
	["builder"]="3.6.0_beta6"
)

inherit calculate-utils-r4

DESCRIPTION="A set of Calculate utilities for system installation, build and upgrade"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate_utilities"
IUSE="+gpg"

RDEPEND="
	gpg? (
		app-crypt/gnupg
		app-crypt/openpgp-keys-calculate-release
	)
"

LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS="~x86 ~amd64"

