# Copyright 1999-2008 Gentoo Foundation    
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit kde4-base

CONTENT_NUMBER="94113"
MY_PN="spellcheck"

DESCRIPTION="Simple plasmoid for fast spell checking."
HOMEPAGE="http://www.kde-look.org/content/show.php/Spell+Check?content=94113"
SRC_URI="http://kde-look.org/CONTENT/content-files/${CONTENT_NUMBER}-${MY_PN}-${PV}.tar.bz2"
LICENSE="GPL"
SLOT="4.2"

KEYWORDS="amd64 x86"

DEPEND=">=kde-base/kdelibs-4.2.0"

S="${WORKDIR}/${MY_PN}-${PV}"

PATCHES=("${FILESDIR}/paste-${PV}.patch")
