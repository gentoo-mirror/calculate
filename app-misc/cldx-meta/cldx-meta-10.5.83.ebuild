# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit calculate

DESCRIPTION="Calculate Linux Desktop XFCE (meta package)"
HOMEPAGE="http://www.calculate-linux.org/main/en/cld"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	app-misc/cls-meta
	app-misc/cl-desktop-meta
	app-misc/cl-xfce-meta
"
# Base
RDEPEND="${RDEPEND}
	x11-misc/slim
"
# Decoration
RDEPEND="${RDEPEND}
	media-gfx/cldx-themes
	x11-themes/tango-icon-theme
"
# Graphics
RDEPEND="${RDEPEND}
	media-gfx/gqview
	media-gfx/gtkam
"
# Multimedia
RDEPEND="${RDEPEND}
	media-sound/audacious
	media-video/gnome-mplayer
	media-video/mplayer
"
# Network
RDEPEND="${RDEPEND}
	net-news/liferea
	mail-client/claws-mail
	mail-client/claws-mail-gtkhtml
	mail-client/claws-mail-rssyl
	net-dialup/gnome-ppp
	net-fs/fusesmb
	net-im/pidgin
	net-irc/xchat
	net-p2p/linuxdcpp
	net-p2p/transmission
	x11-plugins/pidgin-facebookchat
	x11-plugins/pidgin-hotkeys
	x11-plugins/pidgin-libnotify
"
# Nettools
RDEPEND="${RDEPEND}
	net-misc/wicd
"
# Office
RDEPEND="${RDEPEND}
	app-editors/mousepad
	app-text/evince
	app-text/fbreader
	app-text/stardict
	sci-calculators/galculator
"
# Tools
RDEPEND="${RDEPEND}
	app-cdr/xfburn
	sys-block/gparted
	x11-misc/ktsuss
	x11-terms/terminal
"

pkg_postinst() {
	calculate_change_version

	local calculatename=$( get_value calculate < ${CALCULATE_INI} )
	local system=$( get_value system < ${CALCULATE_INI} )

	[[ "$calculatename" == "CLDX" ]] &&
	[[ -n "$(eselect profile show |
		grep calculate/${system}/${calculatename}/${ARCH}/developer)" ]] && 
		eselect profile set calculate/${system}/${calculatename}/${ARCH}
}
