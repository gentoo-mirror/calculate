# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit multilib eutils versionator

DESCRIPTION="Canon UFR II / LIPSLX Printer Driver"
HOMEPAGE="http://www.canon.com/"

SRC_URI="http://files.canon-europe.com/files/soft40355/Software/o1113enx_l_ufr${PV/./}.zip"

LICENSE="CANON"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cngplp"

DEPEND="sys-devel/automake:1.6
	=net-print/cndrvcups-common-${PV}*[cngplp=]"

src_unpack() {
	unpack ${A}
	SRC="UK/Sources/${PF/-r/-}.tar.gz"
	einfo "Unpacking ${SRC}"
	tar xzpf "${SRC}"
	einfo "Removing unnecessary sources"
	rm -rf "UK/"
}

src_configure() {
	for i in ppd pstoufr2cpca backend $( use cngplp && echo cngplp{,/files} ) cpca; do
		cd ${i}
		NOCONFIGURE=1 ./autogen.sh
		case i in
			pstoufr2cpca ) _ECONF_OPTS="--libdir=/usr/libexec --enable-shared --disable-static";;
			cpca ) _ECONF_OPTS="--libdir=/usr/$(get_libdir) --enable-static --disable-shared";;
			* ) _ECONF_OPTS="--libdir=/usr/libexec";;
		esac
		econf ${_ECONF_OPTS}
		cd -
	done
}

src_compile() {
	cd cpca
	emake
	cd -
	emake
}

src_install() {
	emake DESTDIR=${D} install

	OABI=${ABI}
        has_multilib_profile && ABI="x86"
	for i in `cd libs; ls *.so.?.?.?; cd ..`; do
		dolib.so libs/${i}
		dosym ${i} /usr/$(get_libdir)/${i%.?.?}		# Fix the version stuff of libs
		dosym ${i} /usr/$(get_libdir)/${i%.?.?.?}
	done
	dosym /usr/libexec/cups/filter/pstoufr2cpca /usr/$(get_libdir)/cups/filter/

	insinto /usr/share/caepcm
	doins data/*
}
