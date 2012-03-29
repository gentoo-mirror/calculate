# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Linux Desktop OpenBox (meta package)"
HOMEPAGE="http://www.calculate-linux.org/main/en/clsd"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="
calculate_nodecoration
calculate_nographics
calculate_nokernel
calculate_nomultimedia
calculate_nonetwork
calculate_nonettools
calculate_noprinter
calculate_nooffice
calculate_noxorg
calculate_nowireless"

RDEPEND="
	!app-misc/cl-dict-meta
	!app-misc/cl-desktop-meta
	!app-misc/cl-useful-meta
"
RDEPEND="${RDEPEND}
	app-misc/cl-base-meta
	app-misc/cl-tools-meta
	sys-apps/clsd-templates
	x11-misc/tint2
	app-admin/sudo
	x11-misc/xxkb
	app-misc/mc
	x11-misc/obconf
	x11-misc/tintwizard
	x11-misc/parcellite
	x11-misc/gxmessage
	x11-misc/gmrun
	x11-misc/spacefm
	x11-misc/obmenugen-bin
	x11-misc/obdevicemenu
	x11-misc/trayfreq
	sys-apps/uam
	x11-misc/slim
	app-misc/screen
	dev-util/gsimplecal
	!calculate_nodecoration? ( 
		x11-themes/hicolor-icon-theme
		x11-themes/gnome-icon-theme
		media-gfx/cldx-themes
		x11-misc/xscreensaver
		app-misc/cl-decoration-meta
	)
	!calculate_nographics? (
		app-misc/cl-graphics-meta
		media-gfx/feh
		media-gfx/mcomix
	)
	!calculate_nokernel? ( sys-kernel/calculate-sources )
	!calculate_nomultimedia?
	(
		app-misc/cl-multimedia-meta
		media-video/smplayer
		media-sound/deadbeef
		media-sound/volumeicon
	)
	!calculate_nonetwork? ( 
		app-misc/cl-network-meta
		gnome-extra/nm-applet
		net-wireless/blueman
	)
	!calculate_nonettools? ( 
		app-misc/cl-nettools-meta
		net-im/pidgin
		x11-plugins/pidgin-hotkeys
		x11-plugins/pidgin-libnotify
		net-irc/xchat
		app-portage/fetchcommandwrapper
		net-p2p/qbittorrent
	)
	!calculate_noprinter? ( app-misc/cl-printer-meta )
	!calculate_nooffice? (
		app-misc/cl-office-meta
		app-text/evince
	)
	!calculate_noxorg? ( app-misc/cl-xorg-meta )
	!calculate_nowireless? ( app-misc/cl-wireless-meta )
"
