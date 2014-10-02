# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=(python2_7)

inherit distutils-r1 git-2

EGIT_REPO_URI="git://git.calculate.ru/calculate-3/calculate-install.git"

DESCRIPTION="Calculate Linux installation tool"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS=""
IUSE="minimal"

DEPEND="~sys-apps/calculate-lib-3.2.9999
	app-portage/layman
	!minimal? ( sys-boot/grub
	sys-apps/gptfdisk
	sys-fs/dosfstools
	sys-fs/squashfs-tools
	sys-block/parted )"

RDEPEND="${DEPEND}"
