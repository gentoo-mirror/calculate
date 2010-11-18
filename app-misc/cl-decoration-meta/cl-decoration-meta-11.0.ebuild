# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Linux (decoration meta package)"
HOMEPAGE="http://www.calculate-linux.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="distro_CDS distro_CLD distro_CLDG distro_CLDX distro_CLS distro_desktop"

RDEPEND="
	media-gfx/splashutils

	distro_desktop? (
		app-vim/colorschemes
		app-vim/vimcommander
		media-fonts/corefonts
		media-fonts/droid
	)
	distro_CDS? (
		media-gfx/cds-themes
	)
	distro_CLD? (
		media-gfx/cld-themes
		x11-themes/gtk-engines-qtcurve
	)
	distro_CLDG? (
		media-gfx/cldg-themes
		x11-themes/gnome-themes-extras
		x11-themes/tango-icon-theme
		x11-apps/ccsm
		x11-apps/fusion-icon
		x11-wm/compiz-fusion
	)
	distro_CLDX? (
		media-gfx/cldx-themes
		x11-themes/tango-icon-theme
	)
	distro_CLS? (
		media-gfx/cls-themes
	)
"

