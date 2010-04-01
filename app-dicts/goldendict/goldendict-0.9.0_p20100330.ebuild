# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/goldendict/goldendict-0.9.0.ebuild,v 1.1 2010/01/23 13:04:13 hwoarang Exp $

EAPI="2"
LANGS="ru"
inherit qt4-r2 eutils

DESCRIPTION="Feature-rich dictionary lookup program"
HOMEPAGE="http://goldendict.berlios.de/"
SRC_URI="ftp://ftp.calculate.ru/pub/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=app-text/hunspell-1.2
	dev-libs/libzip
	media-libs/libogg
	media-libs/libvorbis
	x11-libs/libXtst
	>=x11-libs/qt-webkit-4.5:4"
DEPEND="${RDEPEND}"

src_configure() {
	PREFIX=/usr eqmake4
}

src_compile() {
	if use linguas_ru ; then
		einfo 'Preparing translations...'
		lrelease ${PN}.pro || die 'lrelease failed'
	fi
	emake || die 'emake failed'
}

src_install() {
	qt4-r2_src_install
	for X in ${LINGUAS} ; do
		for Z in ${LANGS}; do
			if [[ ${X} == ${Z} ]]; then
				insinto /usr/share/apps/${PN}/locale
				doins locale/ru_RU.qm || die 'doins failed'
			fi
		done
	done
}

pkg_postinst() {
	elog 'The portage tree contains various stardict and dictd dictionaries, which'
	elog 'GoldenDict can use. Also, check http://goldendict.berlios.de/dictionaries.php'
	elog 'for more options. The myspell packages can also be useful.'
}
