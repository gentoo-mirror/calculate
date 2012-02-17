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

#removed:
#  gnome-extra/gnome-games
#  www-client/epiphany
#  app-admin/sabayon
#  all accessibility and mono
#  app-admin/pessulus
#  gnome-extra/bug-buddy
RDEPEND="$RDEPEND
	>=gnome-base/gnome-core-libs-${PV}[cups?]

	>=gnome-base/gnome-session-${PV}
	>=gnome-base/gnome-menus-3.2:3
	>=gnome-base/gnome-settings-daemon-${PV}[cups?]
	>=gnome-base/gnome-control-center-${PV}[cups?]

	>=gnome-base/nautilus-${PV}
	>=gnome-base/gnome-keyring-${PV}
	>=gnome-base/libgnome-keyring-3.2
	>=gnome-extra/evolution-data-server-${PV}
	>=gnome-extra/gnome-power-manager-${PV}
	>=gnome-extra/gnome-screensaver-3.2

	>=app-crypt/seahorse-${PV}
	>=app-editors/gedit-${PV}
	>=app-text/evince-${PV}
	>=gnome-extra/gnome-contacts-${PV}
	>=media-gfx/eog-${PV}
	>=media-video/totem-${PV}
	>=x11-terms/gnome-terminal-${PV}

	>=gnome-extra/gnome-user-docs-${PV}
	>=gnome-extra/yelp-${PV}

	>=x11-themes/gtk-engines-2.20.2:2
	>=x11-themes/gnome-icon-theme-${PV}
	>=x11-themes/gnome-icon-theme-symbolic-${PV}
	>=x11-themes/gnome-themes-standard-${PV}

	>=gnome-base/gdm-${PV}

	>=x11-wm/mutter-${PV}
	>=gnome-base/gnome-shell-${PV}

	>=x11-themes/gnome-backgrounds-3.2
	>=x11-themes/gnome-icon-theme-extras-3.0.0
	x11-themes/sound-theme-freedesktop

	>=app-arch/file-roller-${PV}
	>=gnome-extra/gcalctool-6.2.0
	>=gnome-extra/gconf-editor-3.0.0
	>=gnome-extra/gnome-system-monitor-${PV}
	>=gnome-extra/gnome-tweak-tool-${PV}
	>=gnome-extra/gnome-utils-${PV}
	>=gnome-extra/gucharmap-${PV}:2.90
	>=gnome-extra/sushi-0.2.1
	>=mail-client/evolution-${PV}
	>=media-sound/sound-juicer-2.99
	>=media-video/cheese-${PV}
	>=net-analyzer/gnome-nettool-3.0.0
	>=net-misc/vinagre-${PV}
	>=net-misc/vino-${PV}

	>=media-gfx/shotwell-0.11
	>=app-misc/tracker-0.12
	>=gnome-extra/gnome-documents-0.2.1
	gnome-extra/gnome-shell-calculate"
DEPEND="${RDEPEND}"
PDEPEND=">=gnome-base/gvfs-1.10.1[gdu]"

