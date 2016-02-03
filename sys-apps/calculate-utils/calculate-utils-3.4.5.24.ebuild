# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=(python2_7)

declare -A CALCULATE_MODULES=(
	["lib"]="3.4.5.9"
	["install"]="3.4.5.10"
	["core"]="3.4.5.5"
	["i18n"]="3.4.5.10"
	["client"]="3.4.5.1"
	["console-gui"]="3.4.5.1"
	["update"]="3.4.5.7"
	["builder"]="3.4.5.12"
)

inherit calculate-utils

DESCRIPTION="A set of Calculate utilities for system installation, build and upgrade"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate_utilities"

LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS="amd64 x86"

RDEPEND="!sys-libs/db:0"
DEPEND="!sys-libs/db:0"
