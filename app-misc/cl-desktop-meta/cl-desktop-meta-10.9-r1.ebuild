# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Linux (desktop meta package)"
HOMEPAGE="http://www.calculate-linux.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="calculate_nodict"

# Base
RDEPEND="
	app-editors/vim
"

# Decoration
RDEPEND="${RDEPEND}
	app-vim/colorschemes
	app-vim/vimcommander
"

# Developer
RDEPEND="${RDEPEND}
	dev-python/ipython
	dev-tcltk/expect
"

# Dict
RDEPEND="${RDEPEND}
	!calculate_nodict? (
		app-misc/cl-dict-meta
	)
"

# Fonts
DEPEND="${RDEPEND}
	media-fonts/corefonts
	media-fonts/droid
"

# Graphics
RDEPEND="${RDEPEND}
	media-gfx/gimp
	media-gfx/xsane
"

# Hacker
RDEPEND="${RDEPEND}
	net-analyzer/nmap
"

# Multimedia
RDEPEND="${RDEPEND}
	media-libs/win32codecs
	media-sound/alsa-utils
	media-sound/sox
"
# Network
RDEPEND="${RDEPEND}
	net-im/skype
	www-client/chromium
	www-plugins/adobe-flash
"

# Office
RDEPEND="${RDEPEND}
	virtual/ooo
"

# Tools
RDEPEND="${RDEPEND}
	app-admin/sudo
	net-dns/bind-tools
	net-misc/ntp
	sys-apps/calculate-client
	sys-apps/keyexec
	sys-apps/preload
	sys-auth/thinkfinger
	sys-power/acpi
	sys-power/acpid
	sys-power/cpufreqd
	sys-power/powernowd
	x11-apps/mesa-progs
	x11-apps/xdpyinfo
	x11-apps/xev
	x11-apps/xmessage
	x11-misc/xbindkeys
"

