# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Linux Desktop KDE (meta package)"
HOMEPAGE="http://www.calculate-linux.org/main/en/cld"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	app-admin/sudo
	app-antivirus/clamav
	app-arch/rar
	app-cdr/k3b
	app-cdr/k3b-i18n
	app-dicts/aspell-de
	app-dicts/aspell-en
	app-dicts/aspell-es
	app-dicts/aspell-fr
	app-dicts/aspell-pt-br
	app-dicts/aspell-ru
	app-dicts/aspell-uk
	app-dicts/goldendict
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
	app-emulation/wine
	~app-misc/cls-meta-${PV}
	app-office/openoffice
	app-text/fbreader
	dev-python/ipython
	dev-python/psycopg
	dev-tcltk/expect
    ~media-gfx/cld-themes-${PV}
    media-gfx/digikam
    media-gfx/gimp
    media-gfx/xsane
    media-libs/mutagen
    media-libs/win32codecs
    media-plugins/kipi-plugins
    media-sound/amarok
    media-sound/sox
    media-tv/tvtime
    media-video/dvdauthor
    media-video/dvgrab
    media-video/kdenlive
    media-video/recordmydesktop
    media-video/smplayer
    net-analyzer/macchanger
    net-analyzer/nmap
    net-dialup/minicom
    net-dialup/xl2tpd
    net-dns/bind-tools
	net-fs/samba
	net-im/kopete-facebook
    net-irc/konversation
    net-misc/ifenslave
	net-misc/kvpnc
    net-misc/rdesktop
    net-misc/wicd
    net-misc/wol
	net-p2p/eiskaltdc
    net-p2p/ktorrent
    sys-apps/calculate-client
    sys-apps/ethtool
	sys-apps/hdparm
    sys-apps/kexec-tools
    sys-apps/keyexec
    sys-apps/keyutils
	sys-apps/pcmciautils
    sys-apps/preload
	sys-apps/usb_modeswitch
    sys-auth/nss_ldap
    sys-auth/pam_keystore
    sys-auth/pam_ldap
    sys-auth/thinkfinger
    sys-block/partitionmanager
    sys-power/acpi
    sys-power/acpid
    sys-power/cpufreqd
    sys-power/powernowd
    sys-process/htop
	www-plugins/adblock-mozilla-plugin
    www-plugins/adobe-flash
	www-plugins/oxygen-mozilla-plugin
    www-plugins/plasma-mozilla-plugin
    www-plugins/xclear-mozilla-plugin
    x11-apps/mesa-progs
    x11-apps/xdpyinfo
    x11-apps/xev
    x11-misc/xbindkeys
    x11-themes/gtk-engines-qtcurve
"
# kdeadmin-meta
RDEPEND="${RDEPEND}
    kde-base/kcron
    kde-base/knetworkconf
    kde-base/kuser
    kde-base/system-config-printer-kde
"

# kdeartwork-meta
RDEPEND="${RDEPEND}
    kde-base/kdeartwork-colorschemes
    kde-base/kdeartwork-desktopthemes
    kde-base/kdeartwork-emoticons
    kde-base/kdeartwork-iconthemes
    kde-base/kdeartwork-kscreensaver
    kde-base/kdeartwork-sounds
    kde-base/kdeartwork-styles
    kde-base/kdeartwork-wallpapers
    kde-base/kdeartwork-weatherwallpapers
"
# kdebase-meta
RDEPEND="${RDEPEND}
    kde-base/dolphin
	kde-base/kappfinder
	kde-base/kcheckpass
	kde-base/kcminit
	kde-base/kcmshell
	kde-base/kcontrol
	kde-base/kdebase-cursors
	kde-base/kdebase-data
	kde-base/kdebase-desktoptheme
	kde-base/kdebase-kioslaves
	kde-base/kdebase-menu
	kde-base/kdebase-menu-icons
	kde-base/kdebase-startkde
	kde-base/kdebase-wallpapers
	kde-base/kdebugdialog
	kde-base/kdepasswd
	kde-base/kdesu
	kde-base/kdialog
	kde-base/kdm
	kde-base/keditbookmarks
	kde-base/keditfiletype
	kde-base/kephal
	kde-base/kfile
	kde-base/kfind
	kde-base/kglobalaccel
	kde-base/khelpcenter
	kde-base/khotkeys
	kde-base/kiconfinder
	kde-base/kinfocenter
	kde-base/kioclient
	kde-base/klipper
	kde-base/kmenuedit
	kde-base/kmimetypefinder
	kde-base/knetattach
	kde-base/knewstuff
	kde-base/konqueror
	kde-base/konsole
	kde-base/kpasswdserver
	kde-base/kquitapp
	kde-base/kscreensaver
	kde-base/ksmserver
	kde-base/ksplash
	kde-base/kstart
	kde-base/kstartupconfig
	kde-base/kstyles
	kde-base/ksysguard
	kde-base/ksystraycmd
	kde-base/ktimezoned
	kde-base/ktraderclient
	kde-base/kuiserver
	kde-base/kurifilter-plugins
    kde-base/kwalletd
	kde-base/kwin
	kde-base/kwrite
	kde-base/kwrited
	kde-base/libkonq
	kde-base/libkworkspace
	kde-base/libplasmaclock
	kde-base/libtaskmanager
	kde-base/nsplugins
	kde-base/phonon-kde
	kde-base/plasma-apps
	kde-base/plasma-runtime
	kde-base/plasma-workspace
	kde-base/powerdevil
	kde-base/renamedlg-plugins
	kde-base/solid
	kde-base/solid-hardware
	kde-base/solidautoeject
	kde-base/soliduiserver
	kde-base/systemsettings
"
# kdegraphics-meta
RDEPEND="${RDEPEND}
    kde-base/gwenview
	kde-base/kamera
	kde-base/kcolorchooser
	kde-base/kdegraphics-strigi-analyzer
	kde-base/kgamma
	kde-base/kolourpaint
	kde-base/kruler
	kde-base/ksaneplugin
	kde-base/ksnapshot
	kde-base/libkdcraw
	kde-base/libkexiv2
	kde-base/libkipi
	kde-base/libksane
	kde-base/okular
	kde-base/svgpart
	kde-base/thumbnailers
"
# kdemultimedia-meta
RDEPEND="${RDEPEND}
    kde-base/kdemultimedia-kioslaves
	kde-base/kmix
	kde-base/kscd
	kde-base/libkcddb
	kde-base/libkcompactdisc
	kde-base/mplayerthumbs
"

# kdenetwork-meta
RDEPEND="${RDEPEND}
    kde-base/kdenetwork-filesharing
	kde-base/kdnssd
	kde-base/kopete
	kde-base/kppp
	kde-base/krdc
	kde-base/krfb
"

# kdeutils-meta
RDEPEND="${RDEPEND}
    kde-base/ark
	kde-base/kcalc
	kde-base/kcharselect
	kde-base/kdessh
	kde-base/kdf
	kde-base/kgpg
	kde-base/ktimer
	kde-base/kwallet
	kde-base/superkaramba
	kde-base/sweeper
	kde-base/okteta
	kde-base/printer-applet
	kde-base/kdelirc
"

# kdepim-meta
RDEPEND="${RDEPEND}
    kde-base/akonadi
	kde-base/akregator
	kde-base/kabcclient
	kde-base/kaddressbook
	kde-base/kalarm
	kde-base/kdepim-icons
	kde-base/kdepim-kresources
	kde-base/kdepim-strigi-analyzer
	kde-base/kdepim-wizards
	kde-base/kjots
	kde-base/kleopatra
	kde-base/kmail
	kde-base/kmailcvt
	kde-base/knode
	kde-base/knotes
	kde-base/konsolekalendar
	kde-base/kontact
	kde-base/kontact-specialdates
	kde-base/kontactinterfaces
	kde-base/korganizer
	kde-base/ktimetracker
	kde-base/libkdepim
	kde-base/libkleo
	kde-base/libkpgp
	kde-base/libksieve
	kde-base/mimelib
"

# kde-l10n
RDEPEND="${RDEPEND}
    kde-base/kde-l10n
"

# kdemisc
RDEPEND="${RDEPEND}
    kde-base/kate
	kde-base/kdeplasma-addons
	kde-misc/kgtk
	kde-misc/konq-plugins
	kde-misc/openofficeorg-thumbnail
	net-wireless/kbluetooth
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
}
