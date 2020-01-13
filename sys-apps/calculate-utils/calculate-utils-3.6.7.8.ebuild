# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=(python2_7)

declare -A CALCULATE_MODULES=(
	["lib"]="3.6.7.8"
	["install"]="3.6.7.7"
	["core"]="3.6.7.1"
	["i18n"]="3.6.7.3"
	["update"]="3.6.7.1"
	["builder"]="3.6.7.3"
)

inherit calculate-utils-r6

DESCRIPTION="A set of Calculate utilities for system installation, build and upgrade"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate_utilities"

LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS="x86 amd64"

