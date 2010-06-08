# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Linux (useful meta package)"
HOMEPAGE="http://www.calculate-linux.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

# Archive
RDEPEND="
	app-arch/arj
	app-arch/bzip2
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
	app-editors/vim
	sys-apps/hotplug
	sys-apps/ifplugd
	sys-process/vixie-cron
"

# Decoration
RDEPEND="${RDEPEND}
	app-vim/colorschemes
	app-vim/vimcommander
	media-fonts/terminus-font
	media-gfx/splashutils
"

# Tools
RDEPEND="${RDEPEND}
	app-admin/testdisk
	app-cdr/cdrkit
	app-cdr/dvd+rw-tools
	app-misc/mc
	app-portage/eix
	app-portage/genlop
	app-portage/gentoolkit
	app-portage/gentoolkit-dev
	app-portage/portage-utils
	app-portage/ufed
	app-text/wgetpaste
	sys-apps/acl
	sys-apps/hdparm
	sys-apps/memtest86+
	sys-apps/pciutils
	sys-apps/pv
	sys-devel/prelink
	sys-fs/dmraid
	sys-fs/dosfstools
	sys-fs/e2fsprogs
	sys-fs/jfsutils
	sys-fs/mdadm
	sys-fs/mtools
	sys-fs/ntfs3g
	sys-fs/reiserfsprogs
	sys-fs/xfsprogs
	sys-kernel/module-rebuild
	sys-process/htop
"

RDEPEND="${RDEPEND}
	app-admin/testdisk
	app-cdr/cdrkit
	app-cdr/dvd+rw-tools
	app-misc/mc
	app-portage/eix
	app-portage/genlop
	app-portage/gentoolkit
	app-portage/gentoolkit-dev
	app-portage/portage-utils
	app-portage/ufed
	app-text/wgetpaste
	net-fs/nfs-utils
	sys-apps/acl
	sys-apps/hdparm
	sys-apps/memtest86+
	sys-apps/pciutils
	sys-apps/pv
	sys-devel/prelink
	sys-fs/dmraid
	sys-fs/dosfstools
	sys-fs/e2fsprogs
	sys-fs/jfsutils
	sys-fs/mdadm
	sys-fs/mtools
	sys-fs/ntfs3g
	sys-fs/reiserfsprogs
	sys-fs/xfsprogs
	sys-kernel/module-rebuild
	sys-process/htop
"

