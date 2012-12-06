# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Syslinux background for Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/packages/media-gfx/syslinux-themes-calculate"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="themes_CLD themes_CLDX themes_CLS themes_CLDG themes_CSS themes_CDS themes_CMC"

SRC_URI="
themes_CLD? (
	ftp://ftp.calculate.ru/pub/calculate/themes/syslinux/syslinux-cld-13.tar.bz2
)
themes_CLDX? (
	ftp://ftp.calculate.ru/pub/calculate/themes/syslinux/syslinux-cldx-13.tar.bz2
)
themes_CLDG? (
	ftp://ftp.calculate.ru/pub/calculate/themes/syslinux/syslinux-cldg-13.tar.bz2
)
themes_CMC? (
	ftp://ftp.calculate.ru/pub/calculate/themes/syslinux/syslinux-cmc-13.tar.bz2
)
themes_CLS? (
	ftp://ftp.calculate.ru/pub/calculate/themes/syslinux/syslinux-cls-13.tar.bz2
)
themes_CDS? (
	ftp://ftp.calculate.ru/pub/calculate/themes/syslinux/syslinux-cds-13.tar.bz2
)
themes_CSS? (
	ftp://ftp.calculate.ru/pub/calculate/themes/syslinux/syslinux-css-13.tar.bz2
)"

REQUIRED_USE="^^ ( themes_CLD themes_CLDX themes_CLS themes_CLDG themes_CSS
themes_CDS themes_CMC )"

RDEPEND="!<sys-boot/calcboot-4.05.0-r1"

DEPEND="${RDEPEND}"

src_install() {
	insinto /
	doins -r .
}

