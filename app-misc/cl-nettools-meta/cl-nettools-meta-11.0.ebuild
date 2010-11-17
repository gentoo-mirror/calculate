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
IUSE="distro_CLD distro_CLDG distro_CLDX"

RDEPEND="
	net-dns/bind-tools
	net-misc/ntp

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

