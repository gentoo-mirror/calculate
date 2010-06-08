# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Linux (XFCE meta package)"
HOMEPAGE="http://www.calculate-linux.org/main/en/cld"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	xfce-base/xfce4-meta
	xfce-extra/thunar-archive-plugin
	xfce-extra/thunar-thumbnailers
	xfce-extra/thunar-volman
	xfce-extra/xfce4-battery-plugin
	xfce-extra/xfce4-clipman-plugin
	xfce-extra/xfce4-cpugraph-plugin
	xfce-extra/xfce4-datetime-plugin
	xfce-extra/xfce4-mailwatch-plugin
	xfce-extra/xfce4-mixer
	xfce-extra/xfce4-notes-plugin
	xfce-extra/xfce4-notifyd
	xfce-extra/xfce4-power-manager
	xfce-extra/xfce4-screenshooter
	xfce-extra/xfce4-taskmanager
	xfce-extra/xfce4-xkb-plugin
"

