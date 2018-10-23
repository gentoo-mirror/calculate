# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit flag-o-matic toolchain-funcs  multilib eutils versionator
MY_P=${P/_p/-}-1
# S=${WORKDIR}/${PN}-$(get_version_component_range 1-2)

DESCRIPTION="Canon CUPS Capt driver"
HOMEPAGE="http://www.canon.com/"

MY_PV="$(delete_all_version_separators)"
SOURCES_NAME="Linux_CAPT_PrinterDriver_V${MY_PV}_uk_EN"
SRC_URI="http://mirror.slackware.hr/sources/canon/${SOURCES_NAME}.tar.gz"

LICENSE="CANON"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="-cngplp amd64"

DEPEND="=net-print/cndrvcups-common-2.60-r1
	>=net-print/cups-1.1.17"

dir=/usr/$(get_libdir)

QA_TEXTRELS="${dir:1}/libcaiocaptnet.so.1.0.0"

RDEPEND="${DEPEND}
	>=sys-apps/portage-2.1.1_pre1
	app-text/ghostscript-gpl
	!net-print/cndrvcups-lb
	amd64? (
			x11-libs/pangox-compat
			dev-libs/popt[abi_x86_32]
			dev-libs/libxml2[abi_x86_32]
	)
	!amd64? (
			dev-libs/popt
			dev-libs/libxml2
	)"
S=${WORKDIR}/${SOURCES_NAME}/Src/${P/_p/-}-1


pkg_postinst() {
	# create fifo file for comunication with printer
	if [[ ! -d "${ROOT}"/var/ccpd ]]; then
		mkdir -p "${ROOT}"/var/ccpd
	fi

	if [ ! -e "${ROOT}"/var/ccpd/fifo0  ]; then
		mkfifo  -m 600 "${ROOT}"/var/ccpd/fifo0
	fi

	chown lp:lp "${ROOT}"/var/ccpd/fifo0 || die

	einfo "To get your printer working you need to restart cupsd"
	einfo
	einfo "/etc/init.d/cupsd restart"
	einfo
	einfo "Now you can add your printer with either the webinterface or lpadmin"
	einfo
	einfo "/usr/sbin/lpadmin -p LBP3050 -m CNCUPSLBP3050CAPTK.ppd -v ccp:/var/ccpd/fifo0 -E"
	einfo
	einfo "Replace 3050 with either on of the following printers:"
	einfo "1120 1210 2900 3000 3050 3200 3210 3300 5000"
	einfo
	einfo "Now you must register the printer in ccpd, if connected with usb"
	einfo
	einfo "/usr/sbin/ccpdadmin -p LBP3050 -o /dev/usb/lp0"
	einfo
	einfo
	einfo "If you plan to use device /dev/usb/lp0 You will need to un-blacklist module usblp"
	einfo "this is best done by emergeing net-print/cups with USE='-usb' "
	einfo
	einfo "Notice that you can't use LPT port with this driver."
	einfo "If you have a network connection to your printer use -o net:<IP OF PRINTER>"
	einfo "instead of -o /dev/usb/lp0"
	einfo
	einfo "Now you can go ahead and start the ccpd daemon"
	einfo
	einfo "/etc/init.d/ccpd start"
	einfo
	einfo "For monitoring printer use Gui tool: "
	einfo
	einfo "/usr/sbin/captstatusui -p LBP3050"
	einfo
	einfo
	einfo "For more details and toubleshooting please see:"
	einfo
	einfo "https://wiki.gentoo.org/wiki/Canon_CAPT_Printer"
	einfo
	einfo
}



src_unpack() {
	unpack ${A}
	cd "${WORKDIR}/${SOURCES_NAME}/Src/"
	unpack ./${MY_P}.tar.gz

	cd ${MY_P}
	# Fix the cups backend path
	for i in backend pstocapt{,2,3}/filter; do
			sed -i -e 's@libdir@libexecdir@' "${i}/Makefile.am"
	done
}

src_prepare() {
	epatch "${FILESDIR}"/${MY_P}.patch
	export "LIBS=-lpthread"

	if use cngplp; then
	  CNGPLP="cngplp"
	  cd cngplp
	  # files for this one were generate with too old libtool, so we are regenerating
	  autoreconf --install --force
	fi
}

src_configure() {
	NOCONFIGURE=1 ./allgen.sh

	cd driver
	econf --disable-static
	cd ..

	cd cngplp/files
	econf
	cd ../..

	# Disable FORTIFY_SOURCE for statusui
	append-cflags -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=1

	for i in ${CNGPLP} statusui backend pstocapt pstocapt{,2,3} ppd; do

			cd ${i}
			NOCONFIGURE=1 ./autogen.sh
			econf
			cd ..
	done
}

src_compile() {
	for i in ${CNGPLP} statusui driver backend pstocapt{,2,3} ppd ; do
		cd ${i}
		emake
		cd ..
	done
}

src_install() {
	for i in ${CNGPLP} statusui driver backend pstocapt{,2,3} ppd; do
		cd ${i}
		make install DESTDIR=${D}
		cd ..
	done

	cd cngplp/files
	make install DESTDIR=${D}
	cd ../..

	# Install the libs
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

	if use cngplp; then
		for i in $(cd cngplp/.libs; ls *.so.?.?.?; cd ..); do
			dolib.so cngplp/.libs/${i}
			dosym ${i} /usr/$(get_libdir)/${i%.?}
			dosym ${i} /usr/$(get_libdir)/${i%.?.?}
			dosym ${i} /usr/$(get_libdir)/${i%.?.?.?}
		done

		for i in $(cd cngplp; ls *.la; cd ..); do
			dolib.la cngplp/${i}
		done
	fi

	# Install bin
	dobin   libs/captdrv \
		libs/captfilter \
		libs/captemon/captmoncnab6 \
		libs/captemon/captmoncnab7 \
		libs/captemon/captmoncnab8 \
		libs/captemon/captmoncnab9 \
		libs/captemon/captmoncnaba \
		libs/captemon/captmoncnac5 \
		libs/captemon/captmoncnac6 \
		libs/captemon/captmoncnac8 \
		libs/captemon/captmoncnac9 \
		libs/captemon/captmoncnabb \
		libs/captemon/captmoncnabc \
		libs/captemon/captmoncnabd \
		libs/captemon/captmoncnabe \
		libs/captemon/captmoncnabf \
		libs/captemon/captmoncnabg \
		libs/captemon/captmoncnaca \
		libs/captemon/captmonlbp3300 \
		libs/captemon/captmonlbp5000 \
		libs/captmon/captmon \
		libs/captmon2/captmon2

	# Install sbin
	if use amd64; then
		dosbin libs64/ccpd libs64/ccpdadmin
	else
		dosbin libs/ccpd libs/ccpdadmin
	fi

	ABI=${OABI}

	# Install the data
	insinto /usr/share/ccpd
	doins libs/ccpddata/*

	insinto /usr/share/ccpd
	doins libs/captemon/*.BIN

	insinto /usr/share/captmon
	doins libs/captmon/msgtable.xml

	insinto /usr/share/captmon2
	doins libs/captmon2/msgtable2.xml

	insinto /usr/share/captemon
	doins libs/captemon/*.xml

	insinto /usr/share/caepcm
	doins data/CnA* data/CNL*

	insinto /usr/share/captfilter
	doins libs/CnA*

	# Install doc
	dodoc LICENSE* README* COPYING

	for i in statusui driver backend pstocapt{,2,3} ppd; do
		docinto ${i}
		dodoc ${i}/NEWS ${i}/README ${i}/AUTHORS ${i}/ChangeLog ${i}/LICENSE*
	done

	# fix captmon
	dodir /var/captmon
	fowners lp:lp /var/captmon
	keepdir /var/captmon

	# Install startupscripts
	newinitd ${FILESDIR}/${PN}-init.d ccpd

	insinto /etc
	doins samples/ccpd.conf
}
