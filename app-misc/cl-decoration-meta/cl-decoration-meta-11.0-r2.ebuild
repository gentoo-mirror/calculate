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
IUSE="cdistro_CDS cdistro_CLD cdistro_CLDG cdistro_CLDX cdistro_CLS cdistro_desktop"

RDEPEND="
	media-gfx/splashutils

	cdistro_CLS? (
		media-gfx/cls-themes
	)
	cdistro_desktop? (
		app-vim/colorschemes
		app-vim/vimcommander
		media-fonts/corefonts
		media-fonts/droid
	)
	cdistro_CLD? (
		media-gfx/cld-themes
		x11-themes/gtk-engines-qtcurve
	)
	cdistro_CLDG? (
		media-gfx/cldg-themes
		x11-themes/gnome-themes-extras
		x11-themes/tango-icon-theme
		x11-apps/ccsm
		x11-apps/fusion-icon
		x11-wm/compiz-fusion
	)
	cdistro_CLDX? (
		media-gfx/cldx-themes
		x11-themes/tango-icon-theme
	)
	cdistro_CDS? (
		app-vim/colorschemes
		app-vim/vimcommander
		media-gfx/cds-themes
	)
"

