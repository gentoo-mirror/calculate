# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Linux Desktop GNOME (meta package)"
HOMEPAGE="http://www.calculate-linux.org/main/en/cld"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="
	~app-misc/cls-meta-${PV}
	app-antivirus/clamav
	app-arch/rar
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
	app-text/fbreader
	app-office/openoffice
	app-text/stardict
	>=net-misc/networkmanager-0.8
	>=gnome-extra/nm-applet-0.8
	>=net-misc/networkmanager-openvpn-0.8
	>=net-misc/networkmanager-pptp-0.8
	>=net-misc/networkmanager-vpnc-0.8
	~media-gfx/cldg-themes-10.4
	media-gfx/gimp
	media-gfx/xsane
	media-libs/win32codecs
	media-sound/rhythmbox
	media-tv/tvtime
	net-analyzer/nmap
	net-dns/bind-tools
	net-fs/samba
	net-im/pidgin
	net-irc/xchat
	net-misc/rdesktop
	net-misc/wol
	net-p2p/linuxdcpp
	sys-apps/calculate-client
	sys-apps/hdparm
	sys-apps/ethtool
	sys-apps/hdparm
	sys-apps/kexec-tools
	sys-apps/keyexec
	sys-apps/keyutils
	sys-apps/pcmciautils
	sys-apps/preload
	sys-apps/usb_modeswitch
	sys-auth/pam_keystore
	sys-auth/thinkfinger
	sys-block/gparted
	sys-power/acpid
	sys-power/cpufreqd
	sys-power/powernowd
	sys-process/htop
	www-plugins/adblock-mozilla-plugin
	www-plugins/adobe-flash
	www-plugins/spell-mozilla-plugin
	www-plugins/xclear-mozilla-plugin
	x11-themes/gnome-themes-extras
	x11-apps/ccsm
	x11-apps/fusion-icon
	x11-apps/mesa-progs
	x11-apps/xdpyinfo
	x11-apps/xev
	x11-plugins/pidgin-facebookchat
	x11-plugins/pidgin-hotkeys
	x11-themes/tango-icon-theme
	x11-misc/glipper
	x11-misc/xbindkeys
	x11-wm/compiz-fusion"

RDEPEND="${RDEPEND}
	>=dev-libs/glib-2.20.4
	>=x11-libs/gtk+-2.16.5
	>=dev-libs/atk-1.26.0
	>=x11-libs/pango-1.24.5

	>=dev-libs/libxml2-2.7.2
	>=dev-libs/libxslt-1.1.22

	>=media-libs/audiofile-0.2.6-r1
	>=media-sound/esound-0.2.41
	>=x11-libs/libxklavier-3.6
	>=media-libs/libart_lgpl-2.3.20

	>=dev-libs/libIDL-0.8.13
	>=gnome-base/orbit-2.14.16

	>=x11-libs/libwnck-2.26.2
	>=x11-wm/metacity-2.26.0

	>=gnome-base/gnome-keyring-2.26.3
	>=app-crypt/seahorse-2.26.2

	>=gnome-base/gnome-vfs-2.24.1

	>=gnome-base/gnome-mime-data-2.18.0

	>=gnome-base/gconf-2.26.2
	>=net-libs/libsoup-2.26.3

	>=gnome-base/libbonobo-2.24.1
	>=gnome-base/libbonoboui-2.24.1
	>=gnome-base/libgnome-2.26.0
	>=gnome-base/libgnomeui-2.24.1
	>=gnome-base/libgnomecanvas-2.26.0
	>=gnome-base/libglade-2.6.4

	>=gnome-extra/bug-buddy-2.26.0
	>=gnome-base/libgnomekbd-2.26.0
	>=gnome-base/gnome-settings-daemon-2.26.1
	>=gnome-base/gnome-control-center-2.26.0

	>=gnome-base/gvfs-1.2.3
	>=gnome-base/nautilus-2.26.3

	>=media-libs/gstreamer-0.10.23
	>=media-libs/gst-plugins-base-0.10.23
	>=media-libs/gst-plugins-good-0.10.14
	>=gnome-extra/gnome-media-2.26.0
	>=media-sound/sound-juicer-2.26.1
	>=dev-libs/totem-pl-parser-2.26.2
	>=media-video/totem-2.26.3

	>=media-gfx/eog-2.26.3

	>=app-arch/file-roller-2.26.3
	>=gnome-extra/gcalctool-5.26.3

	>=gnome-extra/gconf-editor-2.26.0
	>=gnome-base/gdm-2.20.10
	>=x11-libs/gtksourceview-2.6.2:2.0
	>=app-editors/gedit-2.26.3

	>=app-text/evince-2.26.2

	>=gnome-base/gnome-desktop-2.26.3
	>=gnome-base/gnome-session-2.26.2
	>=dev-libs/libgweather-2.26.2.1
	>=gnome-base/gnome-applets-2.26.3
	>=gnome-base/gnome-panel-2.26.3
	>=gnome-base/gnome-menus-2.26.2
	>=x11-themes/gnome-icon-theme-2.26.0
	>=x11-themes/gnome-themes-2.26.3.1
	>=gnome-extra/deskbar-applet-2.26.2

	>=x11-themes/gtk-engines-2.18.2
	>=x11-themes/gnome-backgrounds-2.24.1

	>=x11-libs/vte-0.20.5
	>=x11-terms/gnome-terminal-2.26.3.1

	>=gnome-extra/gucharmap-2.26.3.1
	>=gnome-base/libgnomeprint-2.18.6
	>=gnome-base/libgnomeprintui-2.18.4

	>=gnome-extra/gnome-utils-2.26.0

	>=gnome-base/librsvg-2.26.0

	>=gnome-extra/gnome-system-monitor-2.26.2
	>=gnome-base/libgtop-2.26.1

	>=x11-libs/startup-notification-0.9

	>=gnome-extra/gnome-user-docs-2.26.2
	>=gnome-extra/yelp-2.26.0
	>=gnome-extra/zenity-2.26.0

	>=net-analyzer/gnome-netstatus-2.26.0
	>=net-analyzer/gnome-nettool-2.26.2

	|| (
		>=app-cdr/brasero-2.26.3
		>=gnome-extra/nautilus-cd-burner-2.24.0 ) 

	>=gnome-extra/gtkhtml-3.26.3
	>=mail-client/evolution-2.26.3
	>=gnome-extra/evolution-data-server-2.26.3
	>=gnome-extra/evolution-webcal-2.26.0

	>=net-misc/vino-2.26.2

	>=app-admin/pessulus-2.26.2
	>=net-voip/ekiga-2.0.12

	>=gnome-extra/gnome-screensaver-2.26.1
	>=x11-misc/alacarte-0.12.1
	>=gnome-extra/gnome-power-manager-2.22.1
	>=gnome-base/gnome-volume-manager-2.24.0

	>=net-misc/vinagre-2.26.2
	>=gnome-extra/swfdec-gnome-2.26.0

	>=gnome-extra/libgail-gnome-1.20.1
	>=gnome-extra/at-spi-1.26.0
	>=gnome-extra/mousetweaks-2.26.3 
	>=net-print/gnome-cups-manager-0.31-r2
	"


