# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kgtk/kgtk-0.10.0.ebuild,v 1.2 2008/08/23 12:14:12 carlo Exp $

ARTS_REQUIRED="never"
EAPI="1"
inherit kde

DESCRIPTION="Allows *some* Gtk applications to use KDE's themes when run under KDE"
HOMEPAGE="http://www.kde-apps.org/content/show.php/gtk-kde4?content=74689"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/74689-gtk-kde4v0.8.tar.gz"
S=$WORKDIR/gtk-kde4

LICENSE="GPL-2"
SLOT="4.1"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND=">=x11-libs/gtk+-2.6
	kde-base/kdelibs:4.1
	x11-themes/gtk-engines-qtpixmap
	|| ( x11-libs/qt-gui:4 x11-libs/qt:4 )"

DEPEND="${RDEPEND}
	>=dev-util/cmake-2.6.1"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# заменяем изображения взплывающего меню
	cp "${FILESDIR}"/menu.png "${S}"/qt4/gtk-2.0/Menu-Menubar/menu.png
}

src_compile() {
	cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr . || die "cmake (configure) failed"
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "make install failed"

	dodoc {readme}
}

pkg_postinst() {
	elog "To see the kde-theme in a gtk-application, just do:"
	elog "ln -s \`kde4-config --localprefix\`/share/config/gtkrc /etc/gtk-2.0"
}
