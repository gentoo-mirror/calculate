# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Linux (wireless meta package)"
HOMEPAGE="http://www.calculate-linux.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

# Developer
#net-wireless/madwimax
RDEPEND="
	net-wireless/b43-firmware
	net-wireless/ipw2100-firmware
	net-wireless/ipw2200-firmware
	net-wireless/iwl1000-ucode
	net-wireless/iwl3945-ucode
	net-wireless/iwl4965-ucode
	net-wireless/iwl5000-ucode
	net-wireless/iwl5150-ucode
	net-wireless/iwl6000-ucode
	net-wireless/iwl6050-ucode
	net-wireless/madwifi-ng
	net-wireless/madwifi-ng-tools
	net-wireless/madwimax
	net-wireless/rt73-firmware
	net-wireless/wireless-tools
	net-wireless/wpa_supplicant
"

