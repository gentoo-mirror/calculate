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
IUSE="calculate_nonetwork cups"

#removed:
#  gnome-extra/gnome-games
#  www-client/epiphany
#  app-admin/sabayon
#  all accessibility and mono
#  app-admin/pessulus
#  gnome-extra/bug-buddy
RDEPEND="$RDEPEND
		!net-print/gnome-cups-manager

        >=dev-libs/glib-2.26.1:2
        >=x11-libs/gtk+-2.22.1-r1:2
        >=x11-libs/gdk-pixbuf-2.22.1:2
        >=dev-libs/atk-1.32.0
        >=x11-libs/pango-1.28.3

        >=dev-libs/libxml2-2.7.2
        >=dev-libs/libxslt-1.1.22

        >=media-libs/audiofile-0.2.7
        >=x11-libs/libxklavier-5.0
        >=media-libs/libart_lgpl-2.3.21

        >=dev-libs/libIDL-0.8.14
        >=gnome-base/orbit-2.14.19

        >=x11-libs/libwnck-2.30.6
        >=x11-wm/metacity-2.30.3

        >=gnome-base/gnome-keyring-2.32.1
        >=gnome-base/libgnome-keyring-2.32.0
        >=app-crypt/seahorse-2.32.0

        >=gnome-base/gconf-2.32.0-r1
        >=net-libs/libsoup-2.32.1

        >=gnome-base/libbonobo-2.24.3
        >=gnome-base/libbonoboui-2.24.4
        >=gnome-base/libgnome-2.32.0
        >=gnome-base/libgnomecanvas-2.30.2
        >=gnome-base/libglade-2.6.4

        >=gnome-base/libgnomekbd-2.32.0
        >=gnome-base/gnome-settings-daemon-2.32.1
        >=gnome-base/gnome-control-center-2.32.0

        >=gnome-base/nautilus-2.32.1

        >=media-libs/gstreamer-0.10.30.2
        >=media-libs/gst-plugins-base-0.10.30.4
        >=media-libs/gst-plugins-good-0.10.23
        >=gnome-extra/gnome-media-2.32.0
        >=media-sound/sound-juicer-2.32.0
        >=dev-libs/totem-pl-parser-2.32.1
        >=media-video/totem-2.32.0
        >=media-video/cheese-2.32.0

        >=media-gfx/eog-2.32.1

        >=app-arch/file-roller-2.32.1
        >=gnome-extra/gcalctool-5.32.1

        >=gnome-extra/gconf-editor-2.32.0
        >=gnome-base/gdm-2.20.11
        >=x11-libs/gtksourceview-2.10.5:2.0
        >=app-editors/gedit-2.30.4

        >=app-text/evince-2.32.0

        >=gnome-base/gnome-desktop-2.32.1:2
        >=gnome-base/gnome-session-2.32.1
        >=dev-libs/libgweather-2.30.3:2
        >=gnome-base/gnome-applets-2.32.0
        >=gnome-base/gnome-panel-2.32.1
        >=gnome-base/gnome-menus-2.30.5
        >=x11-themes/gnome-icon-theme-2.31.0
        >=x11-themes/gnome-themes-2.32.1
        >=gnome-extra/deskbar-applet-2.32.0
        >=gnome-extra/hamster-applet-2.32.1

        >=x11-themes/gtk-engines-2.20.2
        >=x11-themes/gnome-backgrounds-2.32.0

        >=x11-libs/vte-0.26.2
        >=x11-terms/gnome-terminal-2.32.1

        >=gnome-extra/gucharmap-2.32.1
        >=gnome-base/libgnomeprint-2.18.8
        >=gnome-base/libgnomeprintui-2.18.6

        >=gnome-extra/gnome-utils-2.32.0

        >=gnome-base/librsvg-2.32.1

        >=gnome-extra/gnome-system-monitor-2.28.2
        >=gnome-base/libgtop-2.28.2

        >=x11-libs/startup-notification-0.10

        >=gnome-extra/gnome-user-docs-2.32.0
        >=gnome-extra/yelp-2.30.2
        >=gnome-extra/zenity-2.32.1

        >=net-analyzer/gnome-netstatus-2.28.2
        >=net-analyzer/gnome-nettool-2.32.0

        >=app-cdr/brasero-2.32.1

        >=gnome-extra/gtkhtml-3.32.1
        >=mail-client/evolution-2.32.1-r1
        >=gnome-extra/evolution-data-server-2.32.1-r1
        >=gnome-extra/evolution-webcal-2.32.0

        >=net-misc/vino-2.32.0

        >=gnome-extra/gnome-screensaver-2.30.2
        >=x11-misc/alacarte-0.13.2
        >=gnome-extra/gnome-power-manager-2.32.0

        !calculate_nonetwork? ( >=net-misc/vinagre-2.30.3 )
        >=gnome-extra/swfdec-gnome-2.30.1

        cups? ( >=app-admin/system-config-printer-gnome-1.3.3 )

        gnome-extra/polkit-gnome
"
DEPEND=""
PDEPEND=">=gnome-base/gvfs-1.6.6[gdu]"

