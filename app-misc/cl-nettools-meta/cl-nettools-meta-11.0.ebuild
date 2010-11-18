# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Linux (network tools meta package)"
HOMEPAGE="http://www.calculate-linux.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="distro_CDS distro_CLD distro_CLDG distro_CLDX"

RDEPEND="
	net-dns/bind-tools
	net-misc/ntp

	distro_CDS? (
		net-analyzer/fail2ban
		net-analyzer/ipcad
		net-analyzer/iptraf
		net-analyzer/macchanger
		net-analyzer/nmap
		net-analyzer/sarg
		net-analyzer/tcpdump
		net-analyzer/traceroute
		net-analyzer/vnstat
		net-dialup/freeradius
		net-dialup/minicom
		net-dialup/ppp
		net-dialup/pptpclient
		net-dialup/pptpd
		net-dialup/rp-pppoe
		net-dialup/xl2tpd
		net-dns/ddclient
	)

	distro_CLD? (
		net-misc/kvpnc
		net-misc/wicd
	)
	distro_CLDG? (
		gnome-extra/nm-applet
		net-misc/cnetworkmanager
		net-misc/networkmanager
		net-misc/networkmanager-openvpn
		net-misc/networkmanager-pptp
		net-misc/networkmanager-vpnc
		net-wireless/blueman
	)
	distro_CLDX? (
		net-misc/wicd
	)
"

