# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Linux Scratch (meta package)"
HOMEPAGE="http://www.calculate-linux.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="app-admin/logrotate
	app-admin/syslog-ng
	app-admin/testdisk
	app-arch/arj
	app-arch/bzip2
	app-arch/dump
	app-arch/p7zip
	app-arch/unace
	app-arch/unarj
	app-arch/unzip
	app-arch/zip
	app-cdr/cdrkit
	app-cdr/dvd+rw-tools
	app-editors/vim
	app-i18n/enca
	app-misc/livecd-tools
	app-misc/mc
	app-portage/eix
	app-portage/emerge-delta-webrsync
	app-portage/genlop
	app-portage/gentoolkit
	app-portage/layman
	app-portage/portage-utils
	app-portage/ufed
	app-text/wgetpaste
	app-vim/colorschemes
	app-vim/vimcommander
	dev-libs/klibc
	dev-util/git
	media-fonts/corefonts
	media-fonts/droid
	media-fonts/terminus-font
	~media-gfx/cls-themes-${PV}
	media-gfx/splashutils
	media-sound/alsa-utils
	net-analyzer/iptraf
	net-analyzer/tcpdump
	net-analyzer/traceroute
	net-dialup/ppp
	net-dialup/pptpclient
	net-dialup/rp-pppoe
	net-dialup/slmodem
	net-firewall/iptables
	net-fs/nfs-utils
	net-fs/samba
	net-ftp/ftp
	net-misc/dhcpcd
	net-misc/netkit-telnetd
	net-misc/ntp
	net-misc/openvpn
	net-misc/whois
	net-print/foo2zjs
	net-print/gutenprint
	net-print/hplip
	net-wireless/b43-fwcutter
	net-wireless/ipw2100-firmware
	net-wireless/ipw2200-firmware
	net-wireless/iwl3945-ucode
	net-wireless/iwl4965-ucode
	net-wireless/iwl5000-ucode
	net-wireless/madwifi-ng
	net-wireless/madwifi-ng-tools
	net-wireless/wireless-tools
	net-wireless/wpa_supplicant
	sys-apps/bar
	sys-apps/hal
	sys-apps/hotplug
	sys-apps/ifplugd
	sys-apps/iproute2
	sys-apps/memtest86+
	sys-apps/openrc
	sys-apps/pciutils
	sys-apps/pv
	sys-apps/sysvinit
	sys-apps/usbutils
	sys-apps/v86d
	sys-boot/calcboot
	sys-boot/grub
	sys-devel/prelink
	sys-fs/aufs2
	sys-fs/dmraid
	sys-fs/dosfstools
	sys-fs/e2fsprogs
	sys-fs/jfsutils
	sys-fs/mdadm
	sys-fs/mtools
	sys-fs/ntfs3g
	sys-fs/reiserfsprogs
	sys-fs/squashfs-tools
	sys-fs/xfsprogs
	sys-kernel/calckernel
	sys-kernel/module-rebuild
	sys-process/vixie-cron
	www-client/mozilla-firefox
	x11-base/xorg-x11
	x11-drivers/xf86-video-ati
	x11-drivers/xf86-video-intel
	x11-drivers/xf86-video-radeonhd
	x11-wm/openbox
"
