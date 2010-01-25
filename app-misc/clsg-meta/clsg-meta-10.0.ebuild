# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Linux Scratch GNOME (meta package)"
HOMEPAGE="http://www.calculate-linux.org/main/en/cls"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="
	~app-misc/cls-meta-${PV}
	gnome-base/gdm
	gnome-base/gnome-applets
	gnome-base/gnome-light
	~media-gfx/clsg-themes-${PV}
	media-sound/sox
	net-misc/wicd
"
