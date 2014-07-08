# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2:2.7"
RESTRICT_PYTHON_ABIS="2.4 2.5 2.6 3.*"

inherit distutils git-2

EGIT_COMMIT=""
EGIT_REPO_URI="git://git.calculate.ru/calculate-3/calculate-i18n.git"

DESCRIPTION="The internationalization package for calculate utilities"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS=""

RDEPEND=">=sys-apps/calculate-lib-2.2.19"

DEPEND="sys-devel/gettext
	${DEPEND}"
