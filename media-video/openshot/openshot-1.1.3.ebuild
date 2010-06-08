# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_PV="${PV}"
MY_P="${PN}_${MY_PV}"

EAPI="2"

inherit eutils python fdo-mime

DESCRIPTION="OpenShot Video Editor is a free open-source non-linear video
editor based on Python, GTK, and MLT."
HOMEPAGE="http://www.openshotvideo.com"
SRC_URI="http://launchpad.net/openshot/${PV%.[^.]*}/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="faac faad ieee1394 jack mp3 quicktime theora vorbis x264"

DEPEND=""
RDEPEND="
	>=media-libs/mlt-0.4.6-r1[dv,ffmpeg,frei0r,melt,python,quicktime?,xml]
	>=dev-lang/python-2.5[xml]
	dev-python/pygtk
	dev-python/pygoocanvas
	dev-python/pyxdg
	media-video/ffmpeg[encode,ieee1394?,jack?,x264?,vorbis?,theora?,faac?,faad?,mp3?]
	media-sound/sox[encode,ffmpeg]"

src_install() {
	# Install the main OpenShot executable
	dobin bin/openshot || die "failed to install OpenShot executable."

	# Install OpenShot links and icons
	insinto /usr/share/applications
	doins xdg/openshot.desktop || die "failed to install desktop link."
	insinto /usr/share/pixmaps
	doins xdg/openshot.png || die "failed to install desktop icon."
	insinto /usr/share/mime/packages
	doins xdg/openshot.xml || die "failed to install shared mime package."
	insinto /usr/lib/mime/packages
	doins xdg/openshot || die "failed to install mime library."

	# Copy over the rest of OpenShot's files
	insinto /usr/share/openshot
	doins -r openshot/* || die "failed to install OpenShot files."

	# Install omf files
	insinto "/usr/share/omf/${PN}"
	doins docs/omf/* || die "failed to install omf files."

	# Install Gnome help files
	insinto "/usr/share/gnome/help/${PN}"
	doins -r docs/gnome/* || die "failed to install Gnome help files."

	# Install documentation
	doman docs/*.1 || die "failed to install man page."
	dodoc AUTHORS COPYING PKG-INFO README
}

pkg_postinst() {

	# Update our mime database to relect new changes
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update

	elog
	elog "The import and export features of this program rely"
	elog "heavily on its dependencies' USE flags such as"
	elog "media-libs/mlt and media-video/ffmpeg. If you find you"
	elog "can't export or import a certain media format, consider"
	elog "reviewing and modifying these USE flags."
	elog
}

pkg_postrm() {
	# Update our mime database to reflect new changes
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
}
