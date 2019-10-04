# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=(python2_7)

declare -A CALCULATE_MODULES=(
	["lib"]="3.6.4.2"
	["install"]="3.6.4.2"
	["core"]="3.6.4.5"
	["desktop"]="3.6.4.2"
	["console"]="3.6.4.2"
	["console-gui"]="3.6.4.2"
	["builder"]="3.6.4.1"
)

inherit calculate-utils-r5

DESCRIPTION="A set of Calculate utilities for system installation, build and upgrade"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate_utilities"

LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS="x86 amd64"

