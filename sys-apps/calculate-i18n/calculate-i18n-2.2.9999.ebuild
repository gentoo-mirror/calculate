# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit distutils git-2

EGIT_COMMIT=""
EGIT_REPO_URI="git://git.calculate.ru/calculate-i18n.git"

DESCRIPTION="The internationalization package for calculate utilities"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=sys-apps/calculate-lib-2.2.19
	!<sys-apps/calculate-install-2.2.19
	!<sys-apps/calculate-client-2.2.19
	!<sys-apps/calculate-desktop-2.2.19
	!<sys-apps/calculate-builder-2.2.19
	!<sys-apps/calculate-assemble-2.2.19"

DEPEND="sys-devel/gettext
	${DEPEND}"
