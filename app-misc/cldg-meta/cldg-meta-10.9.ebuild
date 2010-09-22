# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit calculate

DESCRIPTION="Calculate Linux Desktop GNOME (meta package)"
HOMEPAGE="http://www.calculate-linux.org/main/en/cld"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	app-misc/cls-meta
	app-misc/cl-desktop-meta
	app-misc/cl-gnome-meta
"

# Decoration
RDEPEND="${RDEPEND}
	media-gfx/cldg-themes
	x11-themes/gnome-themes-extras
	x11-themes/tango-icon-theme
	x11-apps/ccsm
	x11-apps/fusion-icon
	x11-wm/compiz-fusion
"
# Multimedia
RDEPEND="${RDEPEND}
	media-sound/rhythmbox
	media-video/cheese
	media-video/mplayer
"
# Network
RDEPEND="${RDEPEND}
	net-ftp/filezilla
	net-im/pidgin
	net-irc/xchat
	net-misc/pino
	net-p2p/deluge
	net-p2p/linuxdcpp
	x11-plugins/pidgin-facebookchat
	x11-plugins/pidgin-hotkeys
"
# Nettools
RDEPEND="${RDEPEND}
	gnome-extra/nm-applet
	net-misc/networkmanager
	net-misc/networkmanager-openvpn
	net-misc/networkmanager-pptp
	net-misc/networkmanager-vpnc
	net-wireless/blueman
"
# Office
RDEPEND="${RDEPEND}
	app-text/fbreader
	app-text/stardict
	net-news/liferea
"
# Tools
RDEPEND="${RDEPEND}
	sys-block/gparted
	x11-misc/glipper
"

pkg_postinst() {
	calculate_change_version

	local calculatename=$( get_value calculate < ${CALCULATE_INI} )
	local system=$( get_value system < ${CALCULATE_INI} )

	[[ "$calculatename" == "CLDG" ]] &&
	[[ -n "$(eselect profile show |
		grep calculate/${system}/${calculatename}/${ARCH}/developer)" ]] && 
		eselect profile set calculate/${system}/${calculatename}/${ARCH}
}
