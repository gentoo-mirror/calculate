# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Wallpapers for Calculate Linux"
HOMEPAGE="http://www.calculate-linux.org/packages/media-gfx/calculate-wallpapers"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
VERSION_IUSE="CL11 CL12 CL13 CL14 CL15"
IUSE="+CL11 +CL12 +CL13 +CL14 +CL15"

SRC_URI="
	http://mirror.calculate-linux.org/themes/calculate/wallpaper-17.jpg -> ${P}.jpg
	http://mirror.yandex.ru/calculate/themes/calculate/wallpaper-17.jpg -> ${P}.jpg
	CL15? (
		http://mirror.calculate-linux.org/themes/wallpapers/wallpapers-15.tar.bz2
		http://mirror.yandex.ru/calculate/themes/wallpapers/wallpapers-15.tar.bz2
	)
	CL14? (
		http://mirror.calculate-linux.org/themes/wallpapers/wallpapers-14-r1.tar.bz2
		http://mirror.yandex.ru/calculate/themes/wallpapers/wallpapers-14-r1.tar.bz2
	)
	CL11? (
		http://mirror.calculate-linux.org/themes/wallpapers/wallpapers-11.tar.bz2
		http://mirror.yandex.ru/calculate/themes/wallpapers/wallpapers-11.tar.bz2
	)
	CL12? (
		http://mirror.calculate-linux.org/themes/wallpapers/wallpapers-12.tar.bz2
		http://mirror.yandex.ru/calculate/themes/wallpapers/wallpapers-12.tar.bz2
	)
	CL13? (
		http://mirror.calculate-linux.org/themes/wallpapers/wallpapers-13.tar.bz2
		http://mirror.yandex.ru/calculate/themes/wallpapers/wallpapers-13.tar.bz2
	)
	"

DEPEND="!<sys-apps/calculate-utils-3.5.2.6"

# need for templates
RDEPEND="${DEPEND}
	media-gfx/imagemagick"

S="${WORKDIR}"

src_install() {
	insinto /usr/share/themes/Calculate/
	newins "${DISTDIR}"/${P}.jpg wallpaper.jpg

	insinto /
	for useflag in $VERSION_IUSE
	do
		if use $useflag
		then
			cd $WORKDIR/calculate-wallpapers-${useflag//CL}
			if [[ $useflag == CL14 ]]
			then
				mv usr/share/wallpapers/Calculate_Linux usr/share/wallpapers/Calculate_Linux_14
			fi
			if [[ $useflag == CL15 ]]
			then
				mv usr/share/wallpapers/Calculate_Linux usr/share/wallpapers/Calculate_Linux_15
			fi
			doins -r usr
		fi
	done
}
