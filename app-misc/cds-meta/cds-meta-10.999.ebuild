# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit calculate

DESCRIPTION="Calculate Directory Server (meta package)"
HOMEPAGE="http://www.calculate-linux.org/main/en/cds"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="calculate_nodecoration calculate_nokernel calculate_nonettools calculate_nowireless
calculate_nodhcp
calculate_noftp
calculate_nojabber
calculate_nomail
calculate_nomysql
calculate_nonamed
calculate_nopgsql
calculate_noproxy
calculate_nosamba
"

RDEPEND="
	!sys-apps/calculate
"

RDEPEND="${RDEPEND}
	app-misc/cl-base-meta

	!calculate_nodecoration? ( app-misc/cl-decoration-meta )
	!calculate_nokernel? ( sys-kernel/calculate-sources )
	!calculate_nonettools? ( app-misc/cl-nettools-meta )
	!calculate_nowireless? ( app-misc/cl-wireless-meta )

	!calculate_nodhcp? ( net-misc/dhcp )
	!calculate_noftp? (
		net-ftp/ftp
		net-ftp/proftpd
	)
	!calculate_nojabber? ( net-im/calculate-ejabberd )
	!calculate_nomail? (
		mail-filter/clamsmtp
		mail-filter/postgrey
		mail-filter/procmail
		mail-filter/spamassassin
		mail-mta/postfix
		net-mail/dovecot
		net-mail/fetchmail
	)
	!calculate_nomysql? ( dev-db/mysql )
	!calculate_nonamed? ( net-dns/bind )
	!calculate_nopgsql? ( dev-db/postgresql-server )
	!calculate_noproxy? (
		net-proxy/havp
		net-proxy/squid
	)
	!calculate_nosamba? ( net-fs/samba )

"

# Archive
RDEPEND="${RDEPEND} 
	app-arch/arj
	app-arch/dump
	app-arch/p7zip
	app-arch/rar
	app-arch/unace
	app-arch/unarj
	app-arch/unzip
	app-arch/zip
"

# Base
RDEPEND="${RDEPEND}
	app-admin/logrotate
	app-admin/syslog-ng
	sys-apps/hotplug
	sys-process/vixie-cron
"

# LDAP
RDEPEND="${RDEPEND}
	net-nds/openldap
"

# Tools
RDEPEND="${RDEPEND}
	app-admin/hddtemp
	app-admin/testdisk
	app-antivirus/clamav
	app-cdr/cdrkit
	app-cdr/dvd+rw-tools
	app-editors/vim
	app-i18n/enca
	app-misc/mc
	app-misc/screen
	app-portage/emerge-delta-webrsync
	app-portage/genlop
	app-portage/gentoolkit
	app-portage/portage-utils
	app-portage/ufed
	app-text/wgetpaste
	app-vim/colorschemes
	app-vim/vimcommander
	dev-libs/klibc
	dev-python/psycopg
	dev-python/pyserial
	dev-ruby/libxml
	net-firewall/iptables
	net-fs/nfs-utils
	net-irc/cgiirc
	net-irc/weechat
	net-misc/bridge-utils
	net-misc/ifenslave
	net-misc/netkit-telnetd
	net-misc/whois
	net-misc/wol
	net-p2p/bittorrent
	net-p2p/btpd
	sci-libs/fftw
	sys-apps/acl
	sys-apps/calculate-server
	sys-apps/ethtool
	sys-apps/iproute2
	sys-apps/kexec-tools
	sys-apps/memtest86+
	sys-apps/pciutils
	sys-apps/pv
	sys-apps/smartmontools
	sys-apps/usbutils
	sys-auth/nss_ldap
	sys-auth/pam_ldap
	sys-block/parted
	sys-block/tw_cli
	sys-fs/dmraid
	sys-fs/dosfstools
	sys-fs/e2fsprogs
	sys-fs/jfsutils
	sys-fs/mdadm
	sys-fs/mtools
	sys-fs/ntfs3g
	sys-fs/xfsdump
	sys-fs/xfsprogs
	sys-kernel/module-rebuild
	sys-process/htop
	sys-process/lsof
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

	local calculatename=$( get_value calculate < ${CALCULATE_INI} )
	local system=$( get_value system < ${CALCULATE_INI} )

	# check version on stable (PV has only 2 digit)
	if ! [[ "$PV" =~ ^[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+ ]]
	then
		[[ "$calculatename" == "CDS" ]] &&
		[[ -n "$(eselect profile show |
			grep calculate/${system}/${calculatename}/${ARCH}/developer)" ]] && 
			eselect profile set calculate/${system}/${calculatename}/${ARCH}
	fi
}
