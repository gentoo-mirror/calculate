# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="4"

inherit eutils

DESCRIPTION="Keyboard and console utilities"
HOMEPAGE="http://freshmeat.net/projects/kbd/"
SRC_URI="ftp://ftp.altlinux.org/pub/people/legion/kbd/${P}.tar.gz
	ftp://ftp.calculate-linux.ru/pub/calculate/keymaps-addon/keymaps-addon-0.0.1.tar.bz2
	http://mirror.yandex.ru/calculate/keymaps-addon/keymaps-addon-0.0.1.tar.bz2
	ftp://ftp.linux.kiev.ua/pub/Linux/Calculate/keymaps-addon/keymaps-addon-0.0.1.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"
IUSE="nls pam"

RDEPEND="pam? ( virtual/pam )"
DEPEND="${RDEPEND}"

src_unpack() {
	default
	cd "${S}"
	pwd
	cp -r ../keymaps data/

	# broken file ... upstream git punted it
	rm po/es.po

	# Rename conflicting keymaps to have unique names, bug #293228
	cd "${S}"/data/keymaps/i386
	mv dvorak/no.map dvorak/no-dvorak.map
	mv fgGIod/trf.map fgGIod/trf-fgGIod.map
	mv olpc/es.map olpc/es-olpc.map
	mv olpc/pt.map olpc/pt-olpc.map
	mv qwerty/cz.map qwerty/cz-qwerty.map
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-loadkeys-parse.patch #447440
}

src_configure() {
	econf \
		$(use_enable nls) \
		$(use_enable pam vlock)
}

src_install() {
	default
	dohtml doc/*.html
}
