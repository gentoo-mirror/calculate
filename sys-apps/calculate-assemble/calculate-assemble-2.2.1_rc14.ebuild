# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit distutils git

EGIT_COMMIT="0c0ee7859e48b2a02cb9b632bc53106ba2e87d35"
EGIT_REPO_URI="git://git.calculate.ru/calculate-assemble.git"

DESCRIPTION="The utilities for assembling tasks of Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="~sys-apps/calculate-builder-2.2.1_rc14
	~sys-apps/calculate-templates-2.2.1_rc14"

RDEPEND="${DEPEND}"
