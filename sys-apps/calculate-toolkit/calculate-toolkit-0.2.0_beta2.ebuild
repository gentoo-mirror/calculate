# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Collection of administration scripts for Calculate"
HOMEPAGE="http://www.calculate-linux.org"
SRC_URI="ftp://ftp.calculate-linux.org/calculate/source/${PN}/${P}.tar.bz2
	http://mirror.yandex.ru/calculate/source/${PN}/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+themes"

RDEPEND=">=sys-apps/calculate-utils-3.5.0.2
	themes? ( media-gfx/imagemagick )
	app-arch/xz-utils"

src_unpack() {
	unpack $A
	if ! use themes
	then
		sed -i '/cl-theme/d' ${WORKDIR}/${P}/Makefile
		sed -ri 's/^install:.*$/install: all install_cl_kernel_ru.mo install_cl_kernel_fr.mo install_cl_kernel_bg.mo/' ${WORKDIR}/${P}/po/Makefile
	fi
}
