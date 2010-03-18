# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Directory Server (meta package)"
HOMEPAGE="http://www.calculate-linux.org/main/en/cds"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="kernel"

RDEPEND="kernel? ( sys-kernel/calculate-sources )
	app-admin/hddtemp
	app-admin/logrotate
	app-admin/syslog-ng
	app-admin/testdisk
	app-antivirus/clamav
	app-arch/arj
	app-arch/dump
	app-arch/p7zip
	app-arch/rar
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
	app-misc/screen
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
	dev-db/postgresql-server
	dev-libs/klibc
	dev-python/psycopg
	dev-python/pyserial
	dev-ruby/libxml
	dev-vcs/git
	mail-filter/clamsmtp
	mail-filter/postgrey
	mail-filter/procmail
	mail-filter/spamassassin
	mail-mta/postfix
	media-fonts/terminus-font
	~media-gfx/cds-themes-${PV}
	media-gfx/splashutils
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
	net-dns/bind
	net-dns/bind-tools
	net-dns/ddclient
	net-firewall/iptables
	net-fs/nfs-utils
	net-fs/samba
	net-ftp/ftp
	net-ftp/proftpd
	net-im/calculate-ejabberd
	net-irc/cgiirc
	net-irc/weechat
	net-mail/dovecot
	net-mail/fetchmail
	net-misc/bridge-utils
	net-misc/dhcp
	net-misc/ifenslave
	net-misc/netkit-telnetd
	net-misc/ntp
	net-misc/whois
	net-misc/wol
	net-nds/openldap
	net-p2p/bittorrent
	net-p2p/btpd
	net-proxy/havp
	net-proxy/squid
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
	sci-libs/fftw
	sys-apps/acl
	sys-apps/bar
	sys-apps/calculate
	sys-apps/calculate-server
	sys-apps/ethtool
	sys-apps/hal
	sys-apps/hotplug
	sys-apps/ifplugd
	sys-apps/iproute2
	sys-apps/kexec-tools
	sys-apps/memtest86+
	sys-apps/openrc
	sys-apps/parted
	sys-apps/pciutils
	sys-apps/pv
	sys-apps/smartmontools
	sys-apps/usbutils
	sys-apps/v86d
	sys-auth/nss_ldap
	sys-auth/pam_ldap
	sys-block/tw_cli
	sys-boot/calcboot
	sys-boot/grub
	sys-fs/dmraid
	sys-fs/dosfstools
	sys-fs/e2fsprogs
	sys-fs/jfsutils
	sys-fs/mdadm
	sys-fs/mtools
	sys-fs/ntfs3g
	sys-fs/reiserfsprogs
	sys-fs/squashfs-tools
	sys-fs/xfsdump
	sys-fs/xfsprogs
	sys-kernel/calckernel
	sys-kernel/module-rebuild
	sys-power/nut
	sys-process/htop
	sys-process/lsof
	sys-process/vixie-cron
	www-client/links
"

cxxflags_present_in() {
	grep CXXFLAGS $1 &>/dev/null
	return $?
}

append_cxxflags_to() {
	sed -i '$aCXXFLAGS="\${CFLAGS}"' $1
}


pkg_postinst() {
	cxxflags_present_in /etc/make.conf || append_cxxflags_to /etc/make.conf
	calculate_change_version
}
