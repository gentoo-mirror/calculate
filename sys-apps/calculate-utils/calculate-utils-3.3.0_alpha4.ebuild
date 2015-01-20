# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=(python2_7)

UTILS_PV="3.3.0_alpha1"


declare -A CALCULATE_MODULES=(
	["core"]="3.3.0_alpha3"
	["client"]="3.3.0_alpha3"
	["update"]="3.3.0_alpha2"
)

inherit calculate-utils

DESCRIPTION="Calculate Utilities"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"

LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS="~x86 ~amd64"

