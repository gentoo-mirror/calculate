# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

inherit kde eutils distutils subversion

if [[ "${PV}" =~ (_p)([0-9]+) ]] ; then
	ESVN_REVISION=${BASH_REMATCH[2]}
fi
ESVN_REPO_URI="svn://anonsvn.kde.org/home/kde/trunk/extragear/multimedia/k3b"
DESCRIPTION="K3b, KDE CD Writing Software"
HOMEPAGE="http://www.k3b.org/"
LICENSE="GPL-2"
ARTS_REQUIRED="never"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=x11-libs/qt-core-4.3.0
        >=kde-base/kdelibs-4.2.0
        sys-apps/hal
        media-libs/taglib                          
        >=media-sound/cdparanoia-3.9.8             
        media-libs/libsndfile
        >=media-video/ffmpeg-0.4.9_p20080326
        media-libs/flac
        media-libs/libmad
        media-libs/libmpcdec
        media-libs/libvorbis
        media-libs/musicbrainz
        media-sound/lame
        media-libs/alsa-lib"

RDEPEND="${DEPEND}
        virtual/cdrtools
        >=app-cdr/cdrdao-1.1.7-r3
        >=app-cdr/dvd+rw-tools-7.0
        media-libs/libdvdcss
        media-sound/sox           
        media-video/vcdimager"

DEPEND="${DEPEND}
        dev-util/pkgconfig"

src_compile() {
	cmake -DCMAKE_INSTALL_PREFIX=/usr/ || die "cmake failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
