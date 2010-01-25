# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# This ebuild come from http://bugs.gentoo.org/show_bug.cgi?id=130645 - The site http://gentoo.zugaina.org/ only host a copy.
# Small modifications by Ycarus

inherit eutils flag-o-matic multilib


DESCRIPTION="Canon InkJet Printer Driver for Linux (Pixus/Pixma-Series)."
HOMEPAGE="http://support-sg.canon-asia.com/contents/SG/EN/0100160603.html"
RESTRICT="mirror"

SRC_URI="http://gdlp01.c-wss.com/gds/6/0100001606/01/cnijfilter-common-3.00-1.tar.gz"
LICENSE="as-is" # GPL-2 source and proprietary binaries

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="amd64
	cnijtools
	ip1900
	ip3600
	ip4600
	mp190
	mp240
	mp540
	mp630"

DEPEND="app-text/ghostscript-gpl
	>=net-print/cups-1.1.14
	!amd64? ( sys-libs/glibc
		>=dev-libs/popt-1.6
		>=media-libs/tiff-3.4
		>=media-libs/libpng-1.0.9 )
	amd64? ( >=app-emulation/emul-linux-x86-bjdeps-0.1
		app-emulation/emul-linux-x86-compat
		app-emulation/emul-linux-x86-baselibs )
	cnijtools? ( !amd64? ( >=gnome-base/libglade-0.6
			>=dev-libs/libxml-1.8
			>=dev-libs/libxml2-2.6.0
			>=dev-libs/popt-1.4
			>=x11-libs/gtk+-2.6.0
			>=sys-devel/automake-1.9.5
			>=sys-devel/autoconf-2.59 ) 
		amd64? ( >=app-emulation/emul-linux-x86-bjdeps-0.2
				 app-emulation/emul-linux-x86-gtklibs ) )"

# Table of supported Printers and it's IDs
# 	driver name	printers ID	probably compatible printers

_pr1="ip1900"	_prid1="346"
_pr2="ip3600"	_prid2="333"
_pr3="ip4600"	_prid3="334"
_pr4="mp190"	_prid4="342"
_pr5="mp240"	_prid5="341"
_pr6="mp540"	_prid6="338"
_pr7="mp630"	_prid7="336"

###
#   Standard Ebuild-functions
###

pkg_setup() {
	use amd64 && export ABI=x86
	use amd64 && append-flags -L/emul/linux/x86/lib -L/emul/linux/x86/usr/lib -L/usr/lib32 

	_prefix="/usr/local/share"
	_prefix_2="/usr/local"
	_bindir="/usr/local/bin"
	_libdir="/usr/$(get_libdir)"
	_ppddir="/usr/share/cups/model"

	einfo ""
	einfo " USE-FLag cnijtools\tcontains the following (useful!) programs:"
	einfo ""
	einfo "* 'cngpij' is the CUPS front-end GUI program"
	einfo "* 'cngpijmon' is the status monitoring program"
	einfo "* 'lgmon' is a Language monitoring program"
	einfo "* 'printui' is a GUI program for an easily selecting of several parameters for printing"
	einfo ""
	sleep 5

	if ! (use $_pr1 || use $_pr2 || use $_pr3 || use $_pr4 || use $_pr5 || use $_pr6 || use $pr_7); then
		ewarn "You didn't specify any driver model (set it's USE-flag)."
		einfo ""
		einfo "As example:\t MP540 support without maintenance tools"
		einfo "\t\t -> USE=\"mp540\""
		einfo ""
		einfo "Sleeping 10 seconds (Press CTRL+C to abort)"
		einfo ""
		sleep 10
		_autochoose="true"
	else
		_autochoose="false"
	fi
}

src_unpack() { 
	unpack ${A} || die
	
	mv ${PN}-common-${PV} ${P} || die # Correcting directory-structure
}

src_compile() {
	
	cd libs || die
	./autogen.sh || die "Error: libs/autoconf.sh failed"
	make || die "Couldn't make libs"

	cd ../backend || die
	./autogen.sh --prefix=/usr --enable-progpath=${_bindir} || die "Error: backend/autoconf.sh failed"
	make || die "Couldn't make backend"
	
	cd ../pstocanonij || die
	./autogen.sh --prefix=/usr --enable-progpath=${_bindir} || die "Error: pstocanonij/autoconf.sh failed"
	make || die "Couldn't make pstocanonij"
	
#	cd ../ppd || die
#	./autogen.sh --prefix=/usr --program-suffix=${_pr} || die "Error: ppd/autoconf.sh failed"

	if use cnijtools; then
		cd ../cngpij || die
		./autogen.sh --prefix=${_prefix_2} --enable-progpath=${_bindir} || die "Error: cngpij/autoconf.sh failed"
		make || die "Couldn't make cngpij"

		cd ../cngpijmon || die
		./autogen.sh --datadir=${_prefix} --program-suffix=${_pr} || die "Error: cngpijmon/autoconf.sh failed"
		make || die "Couldn't make cngpijmon"
	fi

	cd ..

	_pr=$_pr1 _prid=$_prid1
	if use $_pr || ${_autochoose}; then
		src_compile_pr;
	fi

	_pr=$_pr2 _prid=$_prid2
	if use $_pr || ${_autochoose}; then
		src_compile_pr;
	fi

	_pr=$_pr3 _prid=$_prid3
	if use $_pr || ${_autochoose}; then
		src_compile_pr;
	fi

	_pr=$_pr4 _prid=$_prid4
	if use $_pr || ${_autochoose}; then
		src_compile_pr;
	fi

	_pr=$_pr5 _prid=$_prid5
	if use $_pr || ${_autochoose}; then
		src_compile_pr;
	fi

	_pr=$_pr6 _prid=$_prid6
	if use $_pr || ${_autochoose}; then
		src_compile_pr;
	fi

	_pr=$_pr7 _prid=$_prid7
	if use $_pr || ${_autochoose}; then
		src_compile_pr;
	fi
}

src_install() {
	mkdir -p ${D}${_bindir} || die
	mkdir -p ${D}${_libdir}/cups/filter || die
	mkdir -p ${D}${_ppddir} || die
	mkdir -p ${D}${_libdir}/cnijlib || die

	cd libs || die
	make DESTDIR=${D} install || die "Couldn't make install libs"

	cd ../backend || die
	make DESTDIR=${D} install || die "Couldn't make install backend"

	cd ../pstocanonij || die
	make DESTDIR=${D} install || die "Couldn't make install pstocanoncnij"

#	cd ../ppd || die
#	make DESTDIR=${D} install || die "Couldn't make install ppd"

	if use cnijtools; then
		cd ../cngpij || die
		make DESTDIR=${D} install || die "Couldn't make install cngpij"

		cd ../cngpijmon || die
		make DESTDIR=${D} install || die "Couldn't make install cngpijmon"
	fi

	cd ..

	_pr=$_pr1 _prid=$_prid1
	if use $_pr || ${_autochoose}; then
		src_install_pr;
	fi

	_pr=$_pr2 _prid=$_prid2
	if use $_pr || ${_autochoose}; then
		src_install_pr;
	fi

	_pr=$_pr3 _prid=$_prid3
	if use $_pr || ${_autochoose}; then
		src_install_pr;
	fi

	_pr=$_pr4 _prid=$_prid4
	if use $_pr || ${_autochoose}; then
		src_install_pr;
	fi

	_pr=$_pr5 _prid=$_prid5
	if use $_pr || ${_autochoose}; then
		src_install_pr;
	fi

	_pr=$_pr6 _prid=$_prid6
	if use $_pr || ${_autochoose}; then
		src_install_pr;
	fi

	_pr=$_pr7 _prid=$_prid7
	if use $_pr || ${_autochoose}; then
		src_install_pr;
	fi
}

pkg_postinst() {
	einfo ""
	einfo "For installing a printer:"
	einfo " * Restart CUPS: /etc/init.d/cupsd restart"
	einfo " * Go to http://127.0.0.1:631/"
	einfo "   -> Printers -> Add Printer"
	einfo ""
	einfo "You can find the printerspecific config-file here:"
	einfo " /usr/lib/cnijlib/cif${_pr}.conf"
	einfo ""
	einfo "If you experience any problems, please visit:"
	einfo " http://forums.gentoo.org/viewtopic-p-3217721.html"
	einfo " or"
	einfo " http://forums.gentoo.org/viewtopic-t-723203.html"

	ln -s /usr/lib/cups/filter/pstocanonij /usr/libexec/cups/filter/pstocanonij
	ln -s /usr/lib/cups/backend/cnijusb /usr/libexec/cups/backend/cnijusb
	ln -s /usr/lib/cnijlib /usr/lib/bjlib
	chown 777 /usr/lib/bjlib/*
}

###
#	Custom Helper Functions
###

src_compile_pr()
{
	mkdir ${_pr}
	cp -a ${_prid} ${_pr} || die
	cp -a cnijfilter ${_pr} || die
	cp -a printui ${_pr} || die
	cp -a lgmon ${_pr} || die

	cd ${_pr}/cnijfilter || die # ${_libdir}/bjlib ???
	./autogen.sh --prefix=${_prefix_2} --program-suffix=${_pr} --enable-libpath=${_libdir}/bjlib || die
	make || die "Couldn't make ${_pr}/cnijfilter"

	if use cnijtools; then
		cd ../printui || die
		./autogen.sh --datadir=${_prefix} --program-suffix=${_pr} || die
		make || die "Couldn't make ${_pr}/printui"

		cd ../lgmon || die
		./autogen.sh --program-suffix=${_pr} || die
		make || die "Couldn't make ${_pr}/lgmon"
	fi

	cd ../..
}

src_install_pr()
{
	cd ${_pr}/cnijfilter || die
	make DESTDIR=${D} install || die "Couldn't make install ${_pr}/cnijfilter"

	if use cnijtools; then
		cd ../printui || die
		make DESTDIR=${D} install || die "Couldn't make install ${_pr}/printui"

		cd ../lgmon || die
		make DESTDIR=${D} install || die "Couldn't make install ${_pr}/lgmon"
	fi

	cd ../..
	cp ${_prid}/libs_bin/*.so.* ${D}${_libdir} || die # install -c -s -m 755
	cp ${_prid}/database/* ${D}${_libdir}/cnijlib || die # install -c -s -m 755
	cp ppd/canon${_pr}.ppd ${D}${_ppddir} || die
}

pkg_postrm() {
	rm -f /usr/libexec/cups/filter/pstocanonij
	rm -f /usr/libexec/cups/backend/cnijusb
	rm -f /usr/lib/bjlib
}
