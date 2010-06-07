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
IUSE=""

# Developer
RDEPEND="
	dev-python/ipython
	dev-tcltk/expect
"

# Dict
RDEPEND="${RDEPEND}
	app-dicts/aspell-de
	app-dicts/aspell-en
	app-dicts/aspell-es
	app-dicts/aspell-fr
	app-dicts/aspell-pt-br
	app-dicts/aspell-ru
	app-dicts/aspell-uk
	app-dicts/ispell-de
	app-dicts/ispell-es
	app-dicts/ispell-fr
	app-dicts/ispell-pt-br
	app-dicts/ispell-ru
	app-dicts/myspell-de
	app-dicts/myspell-en
	app-dicts/myspell-es
	app-dicts/myspell-fr
	app-dicts/myspell-pt
	app-dicts/myspell-ru
	app-dicts/myspell-uk
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

# Office
RDEPEND="${RDEPEND}
	app-office/openoffice
"

# Tools
RDEPEND="${RDEPEND}
	app-admin/sudo
	net-dns/bind-tools
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
