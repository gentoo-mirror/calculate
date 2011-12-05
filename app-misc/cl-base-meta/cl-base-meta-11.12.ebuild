# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Linux (base meta package)"
HOMEPAGE="http://www.calculate-linux.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

# Developer
RDEPEND="
	app-portage/eix
	app-portage/gentoolkit
	app-portage/layman
	dev-vcs/git
	media-fonts/terminus-font
	sys-apps/calculate-utilities
	sys-apps/ifplugd
	sys-apps/less
	sys-apps/openrc
	sys-apps/v86d
	sys-boot/calcboot
	sys-boot/grub:0
	>=sys-boot/grub-1.99-r4:2
	sys-boot/os-prober
	sys-fs/btrfs-progs
	sys-fs/nilfs-utils
	sys-fs/reiserfsprogs
	sys-kernel/calckernel
"

