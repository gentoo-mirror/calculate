# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Linux (decoration meta package)"
HOMEPAGE="http://www.calculate-linux.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="cdistro_desktop cdistro_CLD cdistro_CLDG cdistro_CLDX cdistro_CLS cdistro_CMC cdistro_CDS"

RDEPEND="
	!x11-themes/xfce4-icon-theme
	media-gfx/splashutils

	cdistro_CLD? (
		media-gfx/cld-themes
		x11-themes/oxygen-gtk
	)
	cdistro_CLDG? (
		media-gfx/cldg-themes
		x11-themes/gnome-themes-extras
		x11-themes/tango-icon-theme
	)
	cdistro_CLDX? (
		media-gfx/cldx-themes
		x11-themes/gnome-themes-standard
		x11-themes/tango-icon-theme
	)
	cdistro_CLS? (
		media-gfx/cls-themes
	)
	cdistro_CMC? (
		media-gfx/cmc-themes
	)
	cdistro_CDS? (
		media-gfx/cds-themes
	)
"

