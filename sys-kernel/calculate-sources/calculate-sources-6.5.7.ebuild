# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7
ETYPE="sources"

inherit calculate-kernel-8

DESCRIPTION="Calculate Linux kernel image"
KEYWORDS="~amd64"
HOMEPAGE="https://www.calculate-linux.org/"

SRC_URI="${KERNEL_URI} ${ARCH_URI}"

IUSE=""

src_unpack() {
	calculate-kernel-8_src_unpack
}

pkg_postinst() {
	calculate-kernel-8_pkg_postinst
}
