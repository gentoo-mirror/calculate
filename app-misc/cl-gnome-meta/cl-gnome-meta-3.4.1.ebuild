# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Linux (gnome meta package)"
HOMEPAGE="http://www.calculate-linux.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="calculate_nonetwork cups"

# union of gnome,gnome-extra-apps,gnome-core-apps packages
#removed:
#  gnome-extra/gnome-games
#  www-client/epiphany
#  app-admin/sabayon-
#  all accessibility
#  and mono-
#  app-admin/pessulus-
#  gnome-extra/bug-buddy-
#  >=net-im/empathy-${PV}
#  >=app-dicts/gnome-dictionary-3.4
#added:
#  media-plugins/gst-plugins-vp8
#  gnome-extra/gnome-shell-calculate

RDEPEND="${RDEPEND}
	>=gnome-base/gnome-core-libs-${PV}[cups?]

	>=gnome-base/gnome-session-${PV}
	>=gnome-base/gnome-menus-${PV}:3
	>=gnome-base/gnome-settings-daemon-${PV}[cups?]
	>=gnome-base/gnome-control-center-${PV}[cups?]

	>=app-crypt/gcr-${PV}
	>=gnome-base/nautilus-${PV}
	>=gnome-base/gnome-keyring-${PV}
	>=gnome-base/libgnome-keyring-${PV}
	>=gnome-extra/evolution-data-server-${PV}
	>=gnome-extra/gnome-power-manager-3.4
	>=gnome-extra/gnome-screensaver-${PV}

	>=app-crypt/seahorse-${PV}
	>=app-editors/gedit-${PV}
	>=app-text/evince-3.4
	>=gnome-extra/gnome-contacts-${PV}
	>=media-gfx/eog-${PV}
	>=media-video/totem-${PV}
	>=x11-terms/gnome-terminal-${PV}

	>=gnome-extra/gnome-user-docs-${PV}
	>=gnome-extra/yelp-${PV}

	>=x11-themes/gtk-engines-2.20.2:2
	>=x11-themes/gnome-icon-theme-3.4
	>=x11-themes/gnome-icon-theme-symbolic-3.4
	>=x11-themes/gnome-themes-standard-${PV}

	>=gnome-base/gdm-${PV}

	>=x11-wm/mutter-${PV}
	>=gnome-base/gnome-shell-${PV}

	>=x11-themes/gnome-backgrounds-${PV}
	>=x11-themes/gnome-icon-theme-extras-3.4
	x11-themes/sound-theme-freedesktop

	>=gnome-base/gnome-applets-${PV}
	>=gnome-base/gnome-fallback-${PV}

	>=app-arch/file-roller-${PV}
	>=gnome-extra/gcalctool-6.4.1
	>=gnome-extra/gconf-editor-3.0.0
	>=gnome-extra/gnome-system-monitor-${PV}
	>=gnome-extra/gnome-tweak-tool-3.4
	>=gnome-extra/gucharmap-${PV}:2.90
	>=gnome-extra/sushi-0.4.1
	>=mail-client/evolution-${PV}
	>=media-gfx/gnome-font-viewer-3.4
	>=media-gfx/gnome-screenshot-${PV}
	>=media-sound/sound-juicer-3.4
	>=media-video/cheese-${PV}
	>=net-analyzer/gnome-nettool-3.2
	>=net-misc/vinagre-${PV}
	>=net-misc/vino-${PV}
	>=games-board/aisleriot-3.2.3.2
	>=gnome-extra/gnome-search-tool-3.4

	>=media-gfx/shotwell-0.12
	>=app-misc/tracker-0.14.1
	>=gnome-extra/gnome-documents-0.4.1

	gnome-extra/gnome-shell-calculate

	media-plugins/gst-plugins-vp8

	!x11-wm/compiz-fusion
	!x11-apps/fusion-icon
	!x11-libs/compizconfig-backend-gconf
	!x11-apps/ccsm
	!x11-plugins/compiz-plugins-extra
	!dev-python/compizconfig-python
	!x11-plugins/compiz-plugins-main
	!x11-libs/libcompizconfig
	!x11-libs/compiz-bcop
	!x11-wm/compiz"

DEPEND="${RDEPEND}"
PDEPEND=">=gnome-base/gvfs-1.10.1[gdu]"
