# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Linux (graphics meta package)"
HOMEPAGE="http://www.calculate-linux.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="cdistro_CLD cdistro_CLDX"

RDEPEND="
	media-gfx/gimp
	cdistro_CLD? (
		media-gfx/digikam
		sci-libs/clapack
	)
	cdistro_CLDX? (
		media-gfx/gqview
		media-gfx/gtkam
	)
"

