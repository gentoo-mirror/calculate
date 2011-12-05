# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Linux (multimedia meta package)"
HOMEPAGE="http://www.calculate-linux.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="cdistro_CLD cdistro_CLDG cdistro_CLDX"

RDEPEND="
	media-gfx/scrot
	media-sound/alsa-utils
	media-sound/sox
	media-video/mplayer
	cdistro_CLD? (
		app-cdr/k3b
		media-sound/amarok
		media-plugins/kipi-plugins
		media-video/dvdauthor
		media-video/dvgrab
		media-video/kdenlive
		media-video/kffmpegthumbnailer
		media-video/recordmydesktop
		media-video/smplayer
	)
	cdistro_CLDG? (
		media-sound/rhythmbox
		media-video/cheese
	)
	cdistro_CLDX? (
		app-cdr/xfburn
		media-sound/audacious
		media-video/gnome-mplayer
	)

"

