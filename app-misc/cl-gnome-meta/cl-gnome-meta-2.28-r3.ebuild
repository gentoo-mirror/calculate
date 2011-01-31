# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Linux (gnome meta package)"
HOMEPAGE="http://www.calculate-linux.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="calculate_nonetwork"

RDEPEND="
	!gnome-base/gnome-volume-manager
"

RDEPEND="$RDEPEND
	gnome-extra/sensors-applet
"

RDEPEND="$RDEPEND
	>=dev-libs/glib-2.22.4
	>=x11-libs/gtk+-2.18.7
	>=dev-libs/atk-1.28.0
	>=x11-libs/pango-1.26.2

	>=dev-libs/libxml2-2.7.2
	>=dev-libs/libxslt-1.1.22

	>=media-libs/audiofile-0.2.6-r1
	>=x11-libs/libxklavier-3.6
	>=media-libs/libart_lgpl-2.3.20
	>=media-sound/esound-0.2.41

	>=dev-libs/libIDL-0.8.13
	>=gnome-base/orbit-2.14.17

	>=x11-libs/libwnck-2.28.0
	>=x11-wm/metacity-2.28.1

	>=gnome-base/gnome-keyring-2.28.2
	>=app-crypt/seahorse-2.28.1

	>=gnome-base/gconf-2.28.0
	>=net-libs/libsoup-2.28.2

	>=gnome-base/libbonobo-2.24.2
	>=gnome-base/libbonoboui-2.24.2
	>=gnome-base/libgnome-2.28.0
	>=gnome-base/libgnomeui-2.24.2
	>=gnome-base/libgnomecanvas-2.26.0
	>=gnome-base/libglade-2.6.4

	>=gnome-extra/bug-buddy-2.28.0
	>=gnome-base/libgnomekbd-2.28.2
	>=gnome-base/gnome-settings-daemon-2.28.1
	>=gnome-base/gnome-control-center-2.28.1

	>=gnome-base/nautilus-2.28.4

	>=media-libs/gstreamer-0.10.25
	>=media-libs/gst-plugins-base-0.10.25
	>=media-libs/gst-plugins-good-0.10.17
	>=gnome-extra/gnome-media-2.28.5
	>=media-sound/sound-juicer-2.28.1
	>=dev-libs/totem-pl-parser-2.28.2
	>=media-video/totem-2.28.5
	>=media-video/cheese-2.28.1

	>=media-gfx/eog-2.28.2

	>=app-arch/file-roller-2.28.2
	>=gnome-extra/gcalctool-5.28.2

	>=gnome-extra/gconf-editor-2.28.0
	>=gnome-base/gdm-2.20.10-r2
	>=x11-libs/gtksourceview-2.8.2:2.0
	>=app-editors/gedit-2.28.3

	>=app-text/evince-2.28.2

	>=gnome-base/gnome-desktop-2.28.2
	>=gnome-base/gnome-session-2.28.0
	>=dev-libs/libgweather-2.28.0
	>=gnome-base/gnome-applets-2.28.0
	>=gnome-base/gnome-panel-2.28.0
	>=gnome-base/gnome-menus-2.28.0.1
	>=x11-themes/gnome-icon-theme-2.28.0
	>=x11-themes/gnome-themes-2.28.1
	>=gnome-extra/deskbar-applet-2.28.0
	>=gnome-extra/hamster-applet-2.28.2

	>=x11-themes/gtk-engines-2.18.5
	>=x11-themes/gnome-backgrounds-2.28.0

	>=x11-libs/vte-0.22.5
	>=x11-terms/gnome-terminal-2.28.2

	>=gnome-extra/gucharmap-2.28.2
	>=gnome-base/libgnomeprint-2.18.6
	>=gnome-base/libgnomeprintui-2.18.4

	>=gnome-extra/gnome-utils-2.28.3

	>=gnome-base/librsvg-2.26.0

	>=gnome-extra/gnome-system-monitor-2.28.0
	>=gnome-base/libgtop-2.28.0

	>=x11-libs/startup-notification-0.9

	>=gnome-extra/gnome-user-docs-2.28.2
	>=gnome-extra/yelp-2.28.1
	>=gnome-extra/zenity-2.28.0

	>=net-analyzer/gnome-netstatus-2.28.0
	>=net-analyzer/gnome-nettool-2.28.0

	>=app-cdr/brasero-2.28.3

	>=gnome-extra/gtkhtml-3.28.2
	>=mail-client/evolution-2.28.2
	>=gnome-extra/evolution-data-server-2.28.2
	>=gnome-extra/evolution-webcal-2.28.0

	>=net-misc/vino-2.28.1

	>=app-admin/pessulus-2.28.0
	!calculate_nonetwork? ( >=net-voip/ekiga-2.0.12 )

	>=gnome-extra/gnome-screensaver-2.28.3
	>=x11-misc/alacarte-0.12.4
	>=gnome-extra/gnome-power-manager-2.28.3

	!calculate_nonetwork? ( >=net-misc/vinagre-2.28.1 )
	>=gnome-extra/swfdec-gnome-2.28.0

	>=gnome-extra/libgail-gnome-1.20.1
	>=gnome-extra/at-spi-1.28.1
	>=gnome-extra/mousetweaks-2.28.2 
	>=net-print/gnome-cups-manager-0.31-r2
	gnome-extra/polkit-gnome
"
PDEPEND=">=gnome-base/gvfs-1.4.3[gdu]
	=gnome-base/gnome-vfs-2.24.3-r1
	>=gnome-base/gnome-mime-data-2.18.0
"

