# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="7"
PYTHON_COMPAT=(python2_7)

declare -A CALCULATE_MODULES=(
	["lib"]="3.6.8.7"
	["install"]="3.6.8.3"
	["core"]="3.6.8.3"
	["i18n"]="3.6.8.5"
	["client"]="3.6.8.2"
	["desktop"]="3.6.8.6"
	["console-gui"]="3.6.8.2"
)

inherit calculate-utils-r12

DESCRIPTION="A set of Calculate utilities for system installation, build and upgrade"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate_utilities"

LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS="amd64"

