# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Linux (tools meta package)"
HOMEPAGE="http://www.calculate-linux.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="
	cdistro_CDS
	cdistro_desktop
	cdistro_CLD
	cdistro_CLDG
	cdistro_CLDX
	cdistro_CLS
	cdistro_CMC
	calculate_noantivirus
	calculate_noarch
	calculate_nopgsql
	calculate_nosamba
	ldap
"

RDEPEND="${RDEPEND}
	!sys-fs/ntfsprogs
	app-editors/nano
	sys-apps/ethtool
	sys-kernel/module-rebuild

	cdistro_desktop? (
		net-misc/dhcpcd
		sys-apps/pcmciautils
		sys-apps/usb_modeswitch

		app-admin/sudo
		dev-python/ipython
		dev-tcltk/expect
		sys-apps/keyexec
		sys-apps/preload
		sys-auth/thinkfinger
		sys-power/acpi
		sys-power/acpid
		sys-power/cpufreqd
		sys-power/powernowd
		sys-power/powertop
		x11-apps/mesa-progs
		x11-apps/xdpyinfo
		x11-apps/xev
		x11-apps/xmessage
		x11-misc/xcalib
		x11-misc/xbindkeys

		app-admin/hddtemp
		app-admin/testdisk
		app-cdr/cdrkit
		app-cdr/dvd+rw-tools
		!calculate_nosamba? ( app-misc/mc )
		app-portage/gentoolkit-dev
		app-portage/portage-utils
		sys-apps/acl
		sys-apps/gptfdisk
		sys-apps/hdparm
		sys-apps/lm_sensors
		sys-apps/memtest86+
		sys-apps/pciutils
		sys-apps/pv
		sys-apps/smartmontools
		sys-apps/xinetd
		sys-devel/prelink
		sys-fs/dmraid
		sys-fs/dosfstools
		sys-fs/e2fsprogs
		sys-fs/jfsutils
		sys-fs/mdadm
		sys-fs/mtools
		sys-fs/ntfs3g
		sys-fs/xfsprogs
		sys-process/htop
		sys-process/lsof
	)
	cdistro_CLD? (
		net-analyzer/traceroute
		sys-block/partitionmanager
	)
	cdistro_CLDG? (
		net-analyzer/traceroute
		sys-block/gparted
		x11-misc/glipper
	)
	cdistro_CLDX? (
		net-analyzer/traceroute
		!x11-misc/ktsuss
		sys-block/gparted
		x11-terms/terminal
	)
	cdistro_CDS? (
		app-admin/hddtemp
		app-admin/testdisk
		!calculate_noantivirus? ( app-antivirus/clamav )
		app-cdr/cdrkit
		app-cdr/dvd+rw-tools
		app-editors/vim
		app-i18n/enca
		!calculate_nosamba? ( app-misc/mc )
		app-misc/screen
		app-portage/portage-utils
		app-portage/ufed
		dev-libs/klibc
		!calculate_nopgsql? ( dev-python/psycopg )
		dev-python/pyserial
		dev-ruby/libxml
		!calculate_nosamba? ( net-fs/samba )
		net-analyzer/traceroute
		sci-libs/fftw
		sys-apps/acl
		sys-apps/gptfdisk
		sys-apps/iproute2
		sys-apps/lm_sensors
		sys-apps/kexec-tools
		sys-apps/memtest86+
		sys-apps/pciutils
		sys-apps/pv
		sys-apps/smartmontools
		sys-apps/usbutils
		ldap? (
			sys-auth/nss_ldap
			sys-auth/pam_ldap
		)
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
		sys-process/htop
		sys-process/iotop
		sys-process/lsof
	)
	cdistro_CLS? (
		net-misc/dhcpcd
	)
	cdistro_CMC? (
		app-misc/screen
		sys-apps/lm_sensors
		sys-power/powertop
	)
"

# Archive
RDEPEND="${RDEPEND}
	!calculate_noarch? (
		app-arch/arj
		app-arch/dump
		app-arch/p7zip
		app-arch/rar
		app-arch/unace
		app-arch/unarj
		app-arch/unzip
		app-arch/zip
	)
"

# Base
RDEPEND="${RDEPEND}
	app-admin/logrotate
	app-admin/syslog-ng
	!sys-apps/hotplug
	sys-process/vixie-cron
"

