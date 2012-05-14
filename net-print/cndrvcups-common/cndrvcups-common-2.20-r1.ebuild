# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit multilib eutils rpm versionator

DESCRIPTION="Common files for the Canon CUPS Capt driver"
HOMEPAGE="http://www.canon.com/"

SRC_URI="http://files.canon-europe.com/files/soft40355/Software/o1113enx_l_ufr${PV/./}.zip"

LICENSE="CANON"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="-cngplp"    # enable or disable cngplp compilation, may cause build break on ~amd64, don't really know if cngplp is ever needed
RESTRICT=""
EAPI="2"

DEPEND=">=net-print/cups-1.1.17"

dir=/usr/$(get_libdir)
CNGPLP=""

QA_TEXTRELS="${dir:1}/libcaepcm.so.1.0
	${dir:1}/libc3pl.so.0.0.1
	${dir:1}/libcnlbcm.so.1.0
	${dir:1}/libcaiousb.so.1.0.0"

src_unpack() {
	unpack ${A}
	SRC="UK/Sources/${PF/-r/-}.tar.gz"
	einfo "Unpacking ${SRC}"
	tar xzpf "${SRC}"
	einfo "Removing unnecessary sources"
	rm -rf "UK/"
}

src_configure(){
	if hasuse cngplp; then CNGPLP="cngplp"; fi
	for i in buftool ${CNGPLP}; do
		cd ${i}
		NOCONFIGURE=1 ./autogen.sh
		econf
		cd -
	done
}

src_compile() {
	for i in ${CNGPL} buftool; do
		cd ${i}
		emake
		cd -
	done
}

src_install() {
	for i in buftool ${CNGPLP}; do
		cd ${i}
		make install DESTDIR=${D} || die "make install failed for ${i}" 
		cd -
	done

	OABI=${ABI}
	has_multilib_profile && ABI="x86"
	for i in $(cd libs; ls *.so.?.?.?; cd ..); do
		dolib.so libs/${i}
		dosym ${i} /usr/$(get_libdir)/${i%.?}
		dosym ${i} /usr/$(get_libdir)/${i%.?.?}
		dosym ${i} /usr/$(get_libdir)/${i%.?.?.?}
	done
	for i in $(cd libs; ls *.so.?.?; cd ..); do
		dolib.so libs/${i}
		dosym ${i} /usr/$(get_libdir)/${i%.?}
		dosym ${i} /usr/$(get_libdir)/${i%.?.?}
	done

	#dolib.so c3plmod_ipc/libcanonc3pl.so.1.0.0
	dosym  libcanonc3pl.so.1.0.0 /usr/$(get_libdir)/libcanonc3pl.so.1.0
	dosym  libcanonc3pl.so.1.0.0 /usr/$(get_libdir)/libcanonc3pl.so.1
	dosym  libcanonc3pl.so.1.0.0 /usr/$(get_libdir)/libcanonc3pl.so
	
	#dobin libs/cnpkmodule
	dobin libs/c3pldrv

	ABI=${OABI}

	insinto /usr/share/caepcm
	doins data/*


	dodoc LICENSE-common-*.txt README
	for i in buftool c3plmod_ipc ${CNGPLP}; do
		docinto ${i}
		dodoc ${i}/NEWS ${i}/README ${i}/AUTHORS ${i}/ChangeLog
	done
	docinto buftool
	dodoc buftool/LICENSE.txt
}
