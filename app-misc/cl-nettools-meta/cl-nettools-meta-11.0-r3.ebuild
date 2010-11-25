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
IUSE="cdistro_desktop cdistro_CLD cdistro_CLDG cdistro_CLDX cdistro_CDS"

RDEPEND="
	net-dialup/pptpclient
	net-dialup/rp-pppoe
	net-dns/bind-tools
	net-misc/ntp

	cdistro_desktop? (
		net-fs/nfs-utils
	)
	cdistro_CLD? (
		net-misc/kvpnc
		net-misc/cnetworkmanager
		net-misc/networkmanager
		net-misc/networkmanager-openvpn
		net-misc/networkmanager-pptp
		net-misc/networkmanager-vpnc
	)
	cdistro_CLDG? (
		gnome-extra/nm-applet
		net-misc/cnetworkmanager
		net-misc/networkmanager
		net-misc/networkmanager-openvpn
		net-misc/networkmanager-pptp
		net-misc/networkmanager-vpnc
		net-wireless/blueman
	)
	cdistro_CLDX? (
		net-misc/wicd
	)
	cdistro_CDS? (
		net-dialup/freeradius
		net-dialup/ppp
		net-dialup/pptpclient
		net-dialup/pptpd
		net-dialup/rp-pppoe
		net-dialup/xl2tpd
		net-dns/ddclient
		net-firewall/iptables
		net-fs/nfs-utils
		net-fs/samba
		net-misc/bridge-utils
		net-misc/ifenslave
		net-misc/wol
	)
"

