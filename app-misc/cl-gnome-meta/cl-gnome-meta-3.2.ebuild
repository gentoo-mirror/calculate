# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Linux (gnome meta package)"
HOMEPAGE="http://www.calculate-linux.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
#IUSE="calculate_nonetwork cups"

#removed:
#  gnome-extra/gnome-games
#  www-client/epiphany
#  app-admin/sabayon
#  all accessibility and mono
#  app-admin/pessulus
#  gnome-extra/bug-buddy
RDEPEND="$RDEPEND
	gnome-base/gnome
"

