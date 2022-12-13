# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="7"
PYTHON_COMPAT=(python3_9)

UTILS_PV="3.7.2.1"


declare -A CALCULATE_MODULES=(
	["lib"]="3.7.2.38"
	["install"]="3.7.2.16"
	["core"]="3.7.2.8"
	["i18n"]="3.7.2.20"
	["client"]="3.7.2.6"
	["console"]="3.7.2.2"
	["console-gui"]="3.7.2.5"
	["update"]="3.7.2.62"
	["builder"]="3.7.2.49"
)

inherit calculate-utils-r16

DESCRIPTION="A set of Calculate utilities for system installation, build and upgrade"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate_utilities"

LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS="amd64"

