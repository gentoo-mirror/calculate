# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=(python2_7)

UTILS_PV="3.5.0_alpha1"


declare -A CALCULATE_MODULES=(
	["lib"]="3.5.0_alpha14"
	["install"]="3.5.0_alpha6"
	["core"]="3.5.0_alpha13"
	["client"]="3.5.0_alpha5"
	["desktop"]="3.5.0_alpha3"
	["console"]="3.5.0_alpha4"
	["console-gui"]="3.5.0_alpha16"
	["update"]="3.5.0_alpha3"
	["builder"]="3.5.0_alpha3"
	["ldap"]="3.5.0_alpha6"
	["unix"]="3.5.0_alpha3"
)

inherit calculate-utils-r1

DESCRIPTION="A set of Calculate utilities for system installation, build and upgrade"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate_utilities"

LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS=""

