# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=(python2_7)

declare -A CALCULATE_MODULES=(
	["lib"]="3.3.0.6"
	["install"]="3.3.0.7"
	["core"]="3.3.0.3"
	["i18n"]="3.3.0.3"
	["client"]="3.3.0.4"
	["desktop"]="3.3.0.3"
	["console-gui"]="3.3.0.1"
	["update"]="3.3.0.3"
)

inherit calculate-utils

DESCRIPTION="A set of Calculate utilities for system installation, build and upgrade"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate_utilities"

LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS="~amd64 ~x86"

