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
IUSE="distro_desktop distro_CLD distro_CLDG distro_CLDX distro_CDS"

RDEPEND="
	distro_desktop? (
		app-text/wgetpaste
		net-analyzer/nmap
		net-im/skype
		www-client/chromium
		www-plugins/adobe-flash
	)
	distro_CLD? (
		net-im/choqok
		net-irc/konversation
		net-p2p/eiskaltdcpp
	)
	distro_CLDG? (
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
	distro_CDS? (
		app-text/wgetpaste
		net-analyzer/fail2ban
		net-analyzer/ipcad
		net-analyzer/iptraf
		net-analyzer/macchanger
		net-analyzer/nmap
		net-analyzer/sarg
		net-analyzer/tcpdump
		net-analyzer/traceroute
		net-analyzer/vnstat
		net-dialup/minicom
		net-irc/cgiirc
		net-irc/weechat
		net-misc/whois
		net-p2p/bittorrent
		net-p2p/btpd
		www-client/links
	)
"

