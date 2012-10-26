# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Syslinux background for Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/packages/media-gfx/syslinux-themes-calculate"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="themes_cld themes_cldx themes_cls themes_cldg themes_css themes_cds themes_cmc"

SRC_URI="
themes_cld? (
	ftp://ftp.calculate.ru/pub/calculate/themes/syslinux/syslinux-cld-13.tar.bz2
)
themes_cldx? (
	ftp://ftp.calculate.ru/pub/calculate/themes/syslinux/syslinux-cldx-13.tar.bz2
)
themes_cldg? (
	ftp://ftp.calculate.ru/pub/calculate/themes/syslinux/syslinux-cldg-13.tar.bz2
)
themes_cmc? (
	ftp://ftp.calculate.ru/pub/calculate/themes/syslinux/syslinux-cmc-13.tar.bz2
)
themes_cls? (
	ftp://ftp.calculate.ru/pub/calculate/themes/syslinux/syslinux-cls-13.tar.bz2
)
themes_cds? (
	ftp://ftp.calculate.ru/pub/calculate/themes/syslinux/syslinux-cds-13.tar.bz2
)
themes_css? (
	ftp://ftp.calculate.ru/pub/calculate/themes/syslinux/syslinux-css-13.tar.bz2
)"

REQUIRED_USE="^^ ( themes_cld themes_cldx themes_cls themes_cldg themes_css
themes_cds themes_cmc )"

RDEPEND="!<sys-boot/calcboot-4.05.0-r1"

DEPEND="${RDEPEND}"

src_install() {
	insinto /
	doins -r .
}

