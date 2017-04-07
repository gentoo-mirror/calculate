# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=(python2_7)

declare -A CALCULATE_MODULES=(
	["lib"]="3.5.2.18"
	["install"]="3.5.2.6"
	["i18n"]="3.5.2.7"
	["client"]="3.5.2.3"
	["desktop"]="3.5.2.1"
	["update"]="3.5.2.2"
	["builder"]="3.5.2.5"
)

inherit calculate-utils-r1

DESCRIPTION="A set of Calculate utilities for system installation, build and upgrade"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate_utilities"

LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS="amd64 x86"

