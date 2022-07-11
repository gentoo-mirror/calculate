# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="7"
PYTHON_COMPAT=(python3_10)

UTILS_PV="3.7.2.1"


declare -A CALCULATE_MODULES=(
	["lib"]="3.7.2.21"
	["install"]="3.7.2.11"
	["core"]="3.7.2.3"
	["i18n"]="3.7.2.10"
	["client"]="3.7.2.4"
	["console"]="3.7.2.2"
	["update"]="3.7.2.24"
	["builder"]="3.7.2.7"
)

inherit calculate-utils-r15

DESCRIPTION="A set of Calculate utilities for system installation, build and upgrade"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate_utilities"

LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS="amd64"

