# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

ETYPE="sources"

CALC_VER=""

KEYWORDS="amd64 x86"
HOMEPAGE="http://www.calculate-linux.org"

inherit kernel-2
detect_version
detect_arch

CKV=$(get_version_component_range 1-3)

CALC_SUBV=$(get_version_component_range 3-4)

CALC_K_SUBV=$(get_version_component_range 4)

KV_FULL="2.6.${CALC_SUBV}-calculate${CALC_VER}"

EXTRAVERSION=".${CALC_K_SUBV}-calculate${CALC_VER}"
UNIPATCH_STRICTORDER=1

CALC_URI="ftp://mirror.yandex.ru/calculate/${PN}/${PN}-${CKV}.tar.bz2
         http://mirror.yandex.ru/calculate/${PN}/${PN}-${CKV}.tar.bz2
         ftp://ftp.linux.kiev.ua/pub/Linux/Calculate/${PN}/${PN}-${CKV}.tar.bz2"

DESCRIPTION="Full sources including the Calculate patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"

SRC_URI="${KERNEL_URI} ${CALC_URI}"

UNIPATCH_LIST="${DISTDIR}/${PN}-${CKV}.tar.bz2"

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}
