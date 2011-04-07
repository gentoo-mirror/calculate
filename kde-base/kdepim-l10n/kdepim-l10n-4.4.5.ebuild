# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

KMNAME=${PN/pim/}

inherit kde4-base

DESCRIPTION="KDE internationalization package for KDEPIM"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2"

DEPEND="
	!<kde-base/kde-l10n-4.5.0
	sys-devel/gettext
"
RDEPEND=""

KEYWORDS="amd64 ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE=""

MY_LANGS="bg de es fr it pl pt_BR ru uk"

URI_BASE="${SRC_URI/-${PV}.tar.bz2/}"
SRC_URI=""

for MY_LANG in ${MY_LANGS} ; do
	IUSE="${IUSE} linguas_${MY_LANG}"
	SRC_URI="${SRC_URI} linguas_${MY_LANG}? ( ${URI_BASE}/${KMNAME}-${MY_LANG}-${PV}.tar.bz2 )"
done

S="${WORKDIR}"

src_unpack() {
	local LNG DIR CMAKE_FILES
	if [[ -z ${A} ]]; then
		elog
		elog "You either have the LINGUAS variable unset, or it only"
		elog "contains languages not supported by ${P}."
		elog "You won't have any additional language support."
		elog
		elog "${P} supports these language codes:"
		elog "${MY_LANGS}"
		elog
	fi

	# For EAPI >= 3, or if not using .tar.xz archives:
	[[ -n ${A} ]] && unpack ${A}
	cd "${S}"

	# add all linguas to cmake
	if [[ -n ${A} ]]; then
		for LNG in ${LINGUAS}; do
			DIR="${KMNAME}-${LNG}-${PV}"
			if [[ -d "${DIR}" ]] ; then
				echo "add_subdirectory( ${DIR} )" >> "${S}"/CMakeLists.txt

				# comment all install and add_subdirectory entries but those
				# referring to kdepim
				find "$DIR" -mindepth 2 -maxdepth 2 -name CMakeLists.txt -print0 | \
					xargs -0 sed -i \
						-e '/^[[:space:]]*install/s/^/#DONOTINSTALL /' \
						-e '/^[[:space:]]*add_subdirectory/s/^/#DONOTCOMPILE /' \
						-e '/^[[:space:]]*ADD_SUBDIRECTORY/s/^/#DONOTCOMPILE /' \
						-e '/add_subdirectory[[:space:]]*([[:space:]]*kdepim[[:space:]]*)/s/^#DONOTCOMPILE //' \
						-e '/ADD_SUBDIRECTORY[[:space:]]*([[:space:]]*kdepim[[:space:]]*)/s/^#DONOTCOMPILE //' \
						|| die "cmake sed failed"
			fi
		done
	fi
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_build handbook docs)"
	[[ -n ${A} ]] && kde4-base_src_configure
}

src_compile() {
	[[ -n ${A} ]] && kde4-base_src_compile
}

src_test() {
	[[ -n ${A} ]] && kde4-base_src_test
}

src_install() {
	[[ -n ${A} ]] && kde4-base_src_install
}
