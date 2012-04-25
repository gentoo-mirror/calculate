# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Linux (network tools meta package)"
HOMEPAGE="http://www.calculate-linux.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="cdistro_desktop
cdistro_CLD
cdistro_CLDG
cdistro_CLDX
cdistro_CLS
cdistro_CMC
cdistro_CDS
cdistro_CSS
networkmanager"

RDEPEND="
	net-fs/nfs-utils

	cdistro_desktop? (
		net-dialup/pptpclient
		net-dialup/rp-pppoe
		net-dns/bind-tools
		net-misc/ntp
		net-misc/vconfig
		networkmanager? (
			net-misc/cnetworkmanager
			net-misc/networkmanager
			net-misc/networkmanager-openvpn
			net-misc/networkmanager-pptp
			net-misc/networkmanager-vpnc
		)
	)
	cdistro_CLD? (
		networkmanager? (
			kde-misc/networkmanagement
		)
	)
	cdistro_CLDG? (
		gnome-extra/nm-applet
		net-wireless/blueman
	)
	cdistro_CLDX? (
		gnome-extra/nm-applet
		net-wireless/blueman
	)
	cdistro_CDS? (
		net-dialup/ppp
		net-dialup/pptpclient
		net-dialup/pptpd
		net-dialup/rp-pppoe
		net-dialup/xl2tpd
		net-dns/bind-tools
		net-dns/ddclient
		net-firewall/ipsec-tools
		net-firewall/iptables
		net-firewall/shorewall
		net-fs/samba
		net-misc/bridge-utils
		net-misc/ifenslave
		net-misc/ntp
		net-misc/vconfig
		net-misc/wol
	)
"

