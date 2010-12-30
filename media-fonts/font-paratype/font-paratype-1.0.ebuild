# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
inherit font

DESCRIPTION="ParaType font collection for languages of Russia"
HOMEPAGE="http://www.paratype.ru/public/"
SRC_URI="http://www.fontstock.com/public/PTSansOFL.zip
http://www.fontstock.com/public/PTSerifOFL.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X"
RESTRICT="mirror"

DEPEND="app-arch/unzip"
RDEPEND=""

S=${WORKDIR}
FONT_S=${WORKDIR}
FONT_SUFFIX="ttf"
