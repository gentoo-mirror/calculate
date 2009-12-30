# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
inherit calculate

DESCRIPTION="The theme for Calculate Directory Server"
HOMEPAGE="http://www.calculate-linux.org/calcualte-cds-themes"
SRC_URI="ftp://ftp.calculate.ru/pub/calculate/${PN}/${PN}-10.0.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="!media-gfx/calculate-cds-themes"

DEPEND="${RDEPEND}"

src_install() {
	cd ${WORKDIR}/${PN}-10.0
	insinto /
	doins -r .
}

pkg_postinst() {
	calculate_update_splash /boot/initrd
	calculate_update_splash /boot/initrd-install
}
