# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit distutils git

EGIT_COMMIT="6034e9f225a05923de9547f5d95e25184cffdb05"
EGIT_REPO_URI="git://git.calculate.ru/calculate-builder.git"

DESCRIPTION="The utilities for builder tasks of Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=sys-apps/calculate-install-2.2.0.0_p20100930-r2
	<sys-apps/calculate-install-2.2.0.0_p20101001
	>=sys-apps/calculate-templates-2.2.0.0_p20100930-r1
	<sys-apps/calculate-templates-2.2.0.0_p20101001
	!<sys-apps/calculate-1.4.0_p20100921"

RDEPEND="${DEPEND}"
