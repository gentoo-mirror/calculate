# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/plasma-applet-daisy/plasma-applet-daisy-0.0.4.25.ebuild,v 1.2 2011/01/31 14:28:25 tampakrap Exp $

EAPI=4

inherit kde4-base

MYPN="flexibletasks"

DESCRIPTION="Flexible Task Manager for KDE 4's plasma desktop"
HOMEPAGE="http://kde-look.org/content/show.php/Flexible+Tasks?content=129291"
SRC_URI="http://kde-look.org/CONTENT/content-files/129291-${MYPN}-${PV}.zip"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

S="${WORKDIR}/${MYPN}"
