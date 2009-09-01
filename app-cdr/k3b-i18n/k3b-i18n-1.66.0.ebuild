# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

inherit kde4-base eutils

DESCRIPTION="K3b internationalization package"
SRC_URI="ftp://ftp.calculate.ru/pub/calculate/${PN}/${PF}.tar.bz2"
HOMEPAGE="http://www.k3b.org/"
LICENSE="GPL-2"

SLOT="4"
KEYWORDS="~x86 ~amd64"

IUSE=""
LANGS="ru uk fr de pt_BR es pl it"

DEPEND="app-cdr/k3b:4"
RDEPEND="${DEPEND}"

#S="${WORKDIR}"/"${PF}"/"${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"

#	mkdir po 
#	echo 'find_package(Gettext REQUIRED)
#if (NOT GETTEXT_MSGMERGE_EXECUTABLE)
#MESSAGE(FATAL_ERROR "Please install msgmerge binary")
#endif (NOT GETTEXT_MSGMERGE_EXECUTABLE)
#if (NOT GETTEXT_MSGFMT_EXECUTABLE)
#MESSAGE(FATAL_ERROR "Please install msgmerge binary")
#endif (NOT GETTEXT_MSGFMT_EXECUTABLE)' >${S}/po/CMakeLists.txt
#
#	for lg in ${LINGUAS};
#	do
#		if has $lg ${LANGS};
#		then
#			mkdir -p "${S}"/po/${lg}
#			ESVN_PROJECT="${PN}-${lg}.l10n"
#			cp -a ../${ESVN_PROJECT}/extragear-multimedia/* po/${lg}
#			echo "file(GLOB _po_files *.po)
#GETTEXT_PROCESS_PO_FILES(${lg} ALL INSTALL_DESTINATION \${LOCALE_INSTALL_DIR} \${_po_files} )">>${S}/po/${lg}/CMakeLists.txt
#			echo "add_subdirectory(${lg})" >>${S}/po/CMakeLists.txt
#		fi	
#	done
#	echo 'include(MacroOptionalAddSubdirectory)
#macro_optional_add_subdirectory( po )' >>${S}/CMakeLists.txt
}

src_configure() {
	kde4-base_src_configure
}

pkg_postinst() {
	kde4-base_pkg_postinst
}
