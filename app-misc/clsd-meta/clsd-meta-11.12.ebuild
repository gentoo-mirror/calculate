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
calculate_nowireless
linguas_de linguas_en linguas_es linguas_fr linguas_it linguas_pt_BR linguas_ru
"

RDEPEND="
	app-misc/cls-meta
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
	x11-misc/trayfreq
	sys-apps/uam
	sys-power/acpid
	x11-misc/slim
	sys-fs/ntfs3g
	x11-misc/ktsuss
	!calculate_nodecoration? ( 
		x11-themes/hicolor-icon-theme
		x11-themes/gnome-icon-theme
		media-gfx/cld-themes
		app-misc/cl-decoration-meta
	)
	!calculate_nographics? (
		media-gfx/feh
		media-gfx/comix
	)
	!calculate_nokernel? ( sys-kernel/calculate-sources )
	!calculate_nomultimedia?
	(
		media-video/smplayer
		media-sound/deadbeef
		media-sound/volumeicon
		app-misc/cl-multimedia-meta
	)
	!calculate_nonetwork? ( 
		net-dialup/pptpclient
		net-dialup/rp-pppoe
		net-dns/bind-tools
		net-misc/ntp
		net-misc/vconfig
		net-misc/wicd[gtk]
		net-fs/nfs-utils
	)
	!calculate_nonettools? ( 
		net-misc/whois
		net-im/pidgin
		net-irc/xchat
		www-client/firefox-bin
		app-portage/fetchcommandwrapper
		app-text/wgetpaste
		net-analyzer/nmap
		net-analyzer/vnstat
		net-im/skype
		www-plugins/adobe-flash
		x11-misc/x11vnc
		net-wireless/blueman
		net-dialup/qtwvdialer
		net-dialup/mkwvconf
	)
	!calculate_noprinter? ( app-misc/cl-printer-meta )
	!calculate_nooffice? (
		app-text/evince
		app-office/libreoffice-bin
		app-editors/vim
		app-text/fbreader
		linguas_de? (
			app-dicts/aspell-de
			app-dicts/ispell-de
			app-dicts/myspell-de
		)
		linguas_en? (
			app-dicts/aspell-en
			app-dicts/myspell-en
		)
		linguas_es? (
			app-dicts/aspell-es
			app-dicts/ispell-es
			app-dicts/myspell-es
		)
		linguas_fr? (
			app-dicts/aspell-fr
			app-dicts/ispell-fr
			app-dicts/myspell-fr
		)
		linguas_it? (
			app-dicts/aspell-it
			app-dicts/ispell-it
			app-dicts/myspell-it
		)
		linguas_pt_BR? (
			app-dicts/aspell-pt-br
			app-dicts/ispell-pt-br
			app-dicts/myspell-pt
		)
		linguas_ru? (
			app-dicts/aspell-ru
			app-dicts/ispell-ru
			app-dicts/myspell-ru
		)
	)
	!calculate_noxorg? ( app-misc/cl-xorg-meta )
	!calculate_nowireless? ( app-misc/cl-wireless-meta )
"
