# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=4

MYSPELL_DICT=(
	"ru_RU.aff"
	"ru_RU_ie.aff"
	"ru_RU_yo.aff"
	"ru_RU.dic"
	"ru_RU_ie.dic"
	"ru_RU_yo.dic"
)

MYSPELL_HYPH=(
	"hyph_ru_RU.dic"
)

MYSPELL_THES=(
)

inherit myspell-r2

DESCRIPTION="Russian dictionaries for myspell/hunspell"
LICENSE="LGPL-2.1 myspell-ru_RU-ALexanderLebedev"
HOMEPAGE="http://lingucomponent.openoffice.org/"
SRC_URI="mirror://gentoo/myspell-ru_RU-20060316.zip mirror://gentoo/myspell-ru_RU_ye-20060316.zip mirror://gentoo/myspell-ru_RU_yo-20060316.zip mirror://gentoo/myspell-hyph_ru_RU-20060316.zip"
SLOT="0"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~amd64-fbsd ~amd64-linux ~x86-fbsd"
