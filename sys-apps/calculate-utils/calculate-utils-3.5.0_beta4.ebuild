# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=(python2_7)

UTILS_PV="3.5.0_beta1"


declare -A CALCULATE_MODULES=(
	["lib"]="3.5.0_beta2"
	["install"]="3.5.0_beta4"
	["core"]="3.5.0_beta3"
	["i18n"]="3.5.0_beta2"
	["console"]="3.5.0_beta2"
	["console-gui"]="3.5.0_beta3"
	["update"]="3.5.0_beta2"
	["builder"]="3.5.0_beta3"
	["ldap"]="3.5.0_beta2"
	["server"]="3.5.0_beta3"
	["unix"]="3.5.0_beta2"
)

inherit calculate-utils-r1

DESCRIPTION="A set of Calculate utilities for system installation, build and upgrade"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate_utilities"

LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS="~amd64 ~x86"

