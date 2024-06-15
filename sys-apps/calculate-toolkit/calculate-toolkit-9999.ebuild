# Copyright 2008-2024 Mir Calculate
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Collection of administration scripts for Calculate"
HOMEPAGE="https://www.calculate-linux.org"
EGIT_REPO_URI="https://git.calculate-linux.org/calculate/calculate-toolkit.git"

inherit git-r3

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND=">=sys-apps/calculate-utils-3.3.0.10"
