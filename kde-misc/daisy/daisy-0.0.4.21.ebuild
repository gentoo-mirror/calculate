# Copyright 1999-2008 Gentoo Foundation    
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit kde4-base

MY_PN="plasma-applet-daisy"

DESCRIPTION="An icon launcher for Plasma, inspired by Nature."
HOMEPAGE="http://daisyplasma.freehostia.com"
SRC_URI="http://daisyplasma.freehostia.com/downloads/${MY_PN}-${PV}.tar.gz"
LICENSE="GPL-3"
SLOT="4.2"

KEYWORDS="amd64 x86"

DEPEND=">=kde-base/kdelibs-4.3.0"

S="${WORKDIR}/${MY_PN}-${PV}"

