# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit multilib eutils rpm versionator
MY_PF=${PF/-r/-}
DESCRIPTION="Common files for the Canon CUPS Capt driver"
HOMEPAGE="http://www.canon.com/"
SRC_URI="http://files.canon-europe.com/files/soft39340/software/CAPT_Printer_Driver_for_Linux_V200_uk_EN.tar.gz"
LICENSE="CANON"
RESTRICT="mirror"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="-cngplp"    # enable or disable cngplp compilation, may cause build break on ~amd64, don't really know if cngplp is ever needed

DEPEND=">=net-print/cups-1.1.17"
S=${WORKDIR}/${PN}-$(get_version_component_range 1-2)

dir=/usr/$(get_libdir)
CNGPLP=""

QA_TEXTRELS="${dir:1}/libcaepcm.so.1.0
	${dir:1}/libc3pl.so.0.0.1
	${dir:1}/libcnlbcm.so.1.0
	${dir:1}/libcaiousb.so.1.0.0"

src_unpack() {
	unpack ${A}
	unpack ./CAPT_Printer_Driver_for_Linux_V200_uk_EN/Src/${MY_PF}.tar.gz
	cd ${S}
}

src_configure(){
	if hasuse cngplp; then CNGPLP="cngplp"; fi
	for i in buftool ${CNGPLP}; do
		cd ${i}
		NOCONFIGURE=1 ./autogen.sh
		econf
		cd ..
	done
	cd cpca
	NOCONFIGURE=1 ./autogen.sh
	econf --enable-shared --disable-static
	cd ..
}

src_compile() {
	for i in buftool cpca c3plmod_ipc ${CNGPLP}; do
		cd ${i}
		emake
		cd ..
	done
}

src_install() {
	for i in buftool cpca ${CNGPLP}; do
		cd ${i}
		make install DESTDIR=${D} || die "make install failed for ${i}" 
		cd ..
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

	dolib.so c3plmod_ipc/libcanonc3pl.so.1.0.0
	dosym  libcanonc3pl.so.1.0.0 /usr/$(get_libdir)/libcanonc3pl.so.1.0
	dosym  libcanonc3pl.so.1.0.0 /usr/$(get_libdir)/libcanonc3pl.so.1
	dosym  libcanonc3pl.so.1.0.0 /usr/$(get_libdir)/libcanonc3pl.so
	
	dobin libs/cnpkmodule
	dobin libs/c3pldrv

	ABI=${OABI}

	insinto /usr/share/caepcm
	doins data/*


	dodoc LICENSE-common-*.txt README
	for i in buftool cpca c3plmod_ipc ${CNGPLP}; do
		docinto ${i}
		dodoc ${i}/NEWS ${i}/README ${i}/AUTHORS ${i}/ChangeLog
	done
	docinto buftool
	dodoc buftool/LICENSE.txt
}
