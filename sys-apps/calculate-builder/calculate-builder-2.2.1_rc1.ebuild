# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit distutils git

EGIT_COMMIT="11ff3a6e43ae459c376b913c55009b72b5fb70e1"
EGIT_REPO_URI="git://git.calculate.ru/calculate-builder.git"

DESCRIPTION="The utilities for builder tasks of Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="~sys-apps/calculate-install-2.2.1_rc1
	~sys-apps/calculate-templates-2.2.1_rc1
	!<sys-apps/calculate-1.4.0_p20100921"

RDEPEND="${DEPEND}"
