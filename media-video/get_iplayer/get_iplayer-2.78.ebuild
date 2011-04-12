# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="BBC Iplayer downloading application"
HOMEPAGE="http://linuxcentre.net/get_iplayer/"
SRC_URI="ftp://ftp.infradead.org/pub/get_iplayer/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="media-video/mplayer
		media-video/ffmpeg
		media-sound/lame
		media-video/flvstreamer
		dev-perl/libwww-perl
		"
DEPEND=""

src_install() {
	dobin ${PN}
	doman ${PN}.1
	insinto /usr/share/${PN}/plugins
	doins plugins/*
}

