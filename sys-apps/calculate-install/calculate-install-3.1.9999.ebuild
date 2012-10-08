# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2:2.7"
RESTRICT_PYTHON_ABIS="2.4 2.5 2.6 3.*"

inherit distutils git-2

EGIT_REPO_URI="git://git.calculate.ru/calculate-3/calculate-install.git"

DESCRIPTION="The program of installation Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS="~amd64 ~x86"
IUSE="minimal"

DEPEND="~sys-apps/calculate-lib-3.1.9999
	app-portage/layman
	!minimal? ( sys-boot/grub
	sys-apps/gptfdisk
	sys-fs/dosfstools
	sys-fs/squashfs-tools
	sys-block/parted )"

RDEPEND="${DEPEND}"
