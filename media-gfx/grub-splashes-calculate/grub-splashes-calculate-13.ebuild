# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Grub splashes for Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/packages/media-gfx/grub-splashes-calculate"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="themes_cld themes_cldx themes_cls themes_cldg themes_css themes_cds themes_cmc"

SRC_URI="
themes_cld? (
	ftp://ftp.calculate.ru/pub/calculate/themes/grub/grub-cld-13.tar.bz2
)
themes_cldx? (
	ftp://ftp.calculate.ru/pub/calculate/themes/grub/grub-cldx-13.tar.bz2
)
themes_cldg? (
	ftp://ftp.calculate.ru/pub/calculate/themes/grub/grub-cldg-13.tar.bz2
)
themes_cmc? (
	ftp://ftp.calculate.ru/pub/calculate/themes/grub/grub-cmc-13.tar.bz2
)
themes_cls? (
	ftp://ftp.calculate.ru/pub/calculate/themes/grub/grub-cls-13.tar.bz2
)
themes_cds? (
	ftp://ftp.calculate.ru/pub/calculate/themes/grub/grub-cds-13.tar.bz2
)
themes_css? (
	ftp://ftp.calculate.ru/pub/calculate/themes/grub/grub-css-13.tar.bz2
)"

REQUIRED_USE="^^ ( themes_cld themes_cldx themes_cls themes_cldg themes_css
themes_cds themes_cmc )"

RDEPEND="!<sys-boot/calcboot-4.05.0-r1"

DEPEND="${RDEPEND}"

src_install() {
	insinto /
	doins -r .
}

