# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Syslinux background for Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/packages/media-gfx/syslinux-themes-calculate"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

SRC_URI="ftp://ftp.calculate.ru/pub/calculate/themes/syslinux/syslinux-calculate-${PV}.tar.bz2
	http://mirror.yandex.ru/calculate/themes/syslinux/syslinux-calculate-${PV}.tar.bz2"

RDEPEND="!<sys-boot/calcboot-4.05.0-r1"

DEPEND="${RDEPEND}"

src_install() {
	insinto /
	doins -r .
}

