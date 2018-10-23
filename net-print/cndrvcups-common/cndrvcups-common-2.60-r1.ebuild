# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
 
EAPI="2"
inherit multilib eutils rpm versionator
MY_P=${P/_p/-}-1

DESCRIPTION="Common files for the Canon CUPS Capt driver"
HOMEPAGE="http://www.canon.com/"

MY_PV="$(delete_all_version_separators)"
SOURCES_NAME="Linux_CAPT_PrinterDriver_V${MY_PV}_uk_EN"
SRC_URI="http://mirror.slackware.hr/sources/canon/${SOURCES_NAME}.tar.gz"

LICENSE="CANON"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="-cngplp"    # enable or disable cngplp compilation, may cause build break on ~amd64, don't really know if cngplp is ever needed
RESTRICT=""

DEPEND=">=net-print/cups-1.1.17
	>=x11-libs/gtk+-2.0.0
	>=gnome-base/libglade-2.0.0"

S=${WORKDIR}/${PN}-$(get_version_component_range 1-2)

dir=/usr/$(get_libdir)
CNGPLP=""

QA_TEXTRELS="${dir:1}/libcaepcm.so.1.0
	${dir:1}/libc3pl.so.0.0.1
	${dir:1}/libcnlbcm.so.1.0
	${dir:1}/libcaiousb.so.1.0.0"

S=${WORKDIR}/${SOURCES_NAME}/Src/${P/_p/-}-1

src_unpack() {
	if [ "${A}" != "" ]; then
		unpack ${A}
		cd "${WORKDIR}/${SOURCES_NAME}/Src/"
		unpack ./${MY_P}.tar.gz
		cd ${MY_P}
	fi
}

src_prepare() {
	export "LIBS=-lgmodule-2.0"
}

src_configure(){
	make gen
	use cngplp && CNGPLP="cngplp"
}

src_compile() {
	for i in c3plmod_ipc ${CNGPLP}; do
		cd ${i}
		emake
		cd ..
	done
}

src_install() {
	for i in buftool ${CNGPLP}; do
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

	dosym  libcaiousb.so.1.0.0 /usr/$(get_libdir)/libcaiousb.so.1.0
	dosym  libcaiousb.so.1.0.0 /usr/$(get_libdir)/libcaiousb.so.1
	dosym  libcaiousb.so.1.0.0 /usr/$(get_libdir)/libcaiousb.so

#   dobin libs/cnpkmodule
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
