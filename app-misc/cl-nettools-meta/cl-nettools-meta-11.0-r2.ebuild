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
IUSE="distro_desktop distro_CLD distro_CLDG distro_CLDX distro_CDS"

RDEPEND="
	net-dialup/pptpclient
	net-dialup/rp-pppoe
	net-dns/bind-tools
	net-misc/ntp

	distro_desktop? (
		net-fs/nfs-utils
	)
	distro_CLD? (
		net-misc/kvpnc
		net-misc/cnetworkmanager
		net-misc/networkmanager
		net-misc/networkmanager-openvpn
		net-misc/networkmanager-pptp
		net-misc/networkmanager-vpnc
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
	distro_CDS? (
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

