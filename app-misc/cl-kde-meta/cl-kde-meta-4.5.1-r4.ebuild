# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Linux (kde meta package)"
HOMEPAGE="http://www.calculate-linux.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="calculate_nodecoration calculate_nographics calculate_nomultimedia
calculate_nonettools calculate_nonetwork"

RDEPEND="
	!net-misc/wicd
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
	!calculate_nodecoration? (
		kde-base/kdeartwork-colorschemes
		kde-base/kdeartwork-desktopthemes
		kde-base/kdeartwork-emoticons
		kde-base/kdeartwork-iconthemes
		kde-base/kdeartwork-kscreensaver
		kde-base/kdeartwork-sounds
		kde-base/kdeartwork-styles
		kde-base/kdeartwork-wallpapers
		kde-base/kdeartwork-weatherwallpapers
	)
"
# kdebase-meta
#- kde-base/konqueror
#- kde-base/nsplugins
RDEPEND="${RDEPEND}
	kde-base/dolphin
	kde-base/freespacenotifier
	kde-base/kcheckpass
	kde-base/kcminit
	kde-base/kdebase-cursors
	kde-base/kdebase-runtime-meta
	kde-base/kdebase-startkde
	kde-base/kdebase-wallpapers
	kde-base/kdepasswd
	kde-base/kdialog
	kde-base/keditbookmarks
	kde-base/kephal
	kde-base/kfind
	kde-base/kfmclient
	kde-base/khotkeys
	kde-base/kinfocenter
	kde-base/klipper
	kde-base/kmenuedit
	kde-base/konsole
	kde-base/kscreensaver
	kde-base/ksmserver
	kde-base/ksplash
	kde-base/kstartupconfig
	kde-base/kstyles
	kde-base/ksysguard
	kde-base/ksystraycmd
	kde-base/kwin
	kde-base/kwrite
	kde-base/kwrited
	kde-base/libkonq
	kde-base/libkworkspace
	kde-base/liboxygenstyle
	kde-base/libplasmaclock
	kde-base/libplasmagenericshell
	kde-base/libtaskmanager
	kde-base/phonon-kde
	kde-base/plasma-apps
	kde-base/plasma-workspace
	kde-base/powerdevil
	kde-base/qguiplatformplugin_kde
	kde-base/solid
	kde-base/systemsettings
	kde-base/kdm                                                                               
	sys-auth/polkit-kde
"

# kdegraphics-meta
RDEPEND="${RDEPEND}
	!calculate_nographics? (
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
	)
"

# kdemultimedia-meta
RDEPEND="${RDEPEND}
	!calculate_nomultimedia? (
		kde-base/kdemultimedia-kioslaves
		kde-base/kmix
		kde-base/kscd
		kde-base/libkcddb
		kde-base/libkcompactdisc
		kde-base/mplayerthumbs
		kde-base/ffmpegthumbs
	)
"

# kdenetwork-meta
RDEPEND="${RDEPEND}
	!calculate_nonettools? (
		kde-base/kdenetwork-filesharing
		kde-base/kdnssd
		kde-base/kopete
		kde-base/kppp
		kde-base/krdc
		kde-base/krfb
	)
"

# kdeutils-meta
#- kde-base/ktimer
#- kde-base/okteta
RDEPEND="${RDEPEND}
    kde-base/ark
	kde-base/kcalc
	kde-base/kcharselect
	kde-base/kdf
	kde-base/kgpg
	kde-base/kremotecontrol
	kde-base/kwallet
	kde-base/sweeper
	kde-base/printer-applet
"

# kdepim-meta
#- kde-base/ktimetracker
#- kde-base/kdepim-wizards
#- kde-base/knode
RDEPEND="${RDEPEND}
	!calculate_nonetwork? (
		kde-base/akonadi
		kde-base/akregator
		kde-base/kabcclient
		kde-base/kaddressbook
		kde-base/kalarm
		kde-base/kdepim-icons
		kde-base/kdepim-kresources
		kde-base/kdepim-runtime
		kde-base/kdepim-strigi-analyzer
		kde-base/kjots
		kde-base/kleopatra
		kde-base/kmail
		kde-base/knotes
		kde-base/konsolekalendar
		kde-base/kontact
		kde-base/korganizer
		kde-base/libkdepim
		kde-base/libkleo
		kde-base/libkpgp
	)
"

# kde-l10n
RDEPEND="${RDEPEND}
	kde-base/kde-l10n
	kde-base/kdepim-l10n
"

# kdemisc
#- kde-misc/konq-plugins
#- kde-misc/kgtk
RDEPEND="${RDEPEND}
	kde-base/kate
	kde-base/kdeplasma-addons
	kde-base/kget
"

