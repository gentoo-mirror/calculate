# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Linux (network meta package)"
HOMEPAGE="http://www.calculate-linux.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="distro_CLD distro_CLDG distro_CLDX"

RDEPEND="
	net-dialup/pptpclient
	net-dialup/rp-pppoe

	distro_CLD? (
		net-analyzer/nmap
		net-im/skype
		www-client/chromium
		www-plugins/adobe-flash

		net-im/choqok
		net-irc/konversation
		net-p2p/eiskaltdcpp
	)
	distro_CLDG? (
		net-analyzer/nmap
		net-im/skype
		www-client/chromium
		www-plugins/adobe-flash

		net-ftp/filezilla
		net-im/pidgin
		net-irc/xchat
		net-misc/pino
		net-p2p/deluge
		net-p2p/linuxdcpp
		x11-plugins/pidgin-facebookchat
		x11-plugins/pidgin-hotkeys
	)
	distro_CLDX? (
		net-analyzer/nmap
		net-im/skype
		www-client/chromium
		www-plugins/adobe-flash

		app-cdr/xfburn
		net-ftp/filezilla
		net-news/liferea
		mail-client/claws-mail
		mail-client/claws-mail-rssyl
		net-dialup/gnome-ppp
		net-fs/fusesmb
		net-im/pidgin
		net-irc/xchat
		net-misc/pino
		net-p2p/deluge
		net-p2p/linuxdcpp
		x11-plugins/pidgin-facebookchat
		x11-plugins/pidgin-hotkeys
		x11-plugins/pidgin-libnotify
	)
"

