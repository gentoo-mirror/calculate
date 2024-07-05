# Copyright 2007-2024 Mir Calculate
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=(python3_11)

declare -A CALCULATE_MODULES=(
	["lib"]="3.7.5.5"
	["install"]="3.7.5.2"
	["i18n"]="3.7.5.5"
	["builder"]="3.7.5.3"
)

inherit calculate-utils-r17

DESCRIPTION="A set of Calculate utilities for system installation, build and upgrade"
HOMEPAGE="https://www.calculate-linux.org/main/en/calculate_utilities"

LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS="amd64"
