# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Console client for Yandex.Disk"
HOMEPAGE="https://disk.yandex.ru/"
SRC_URI="
        x86?    ( http://repo.yandex.ru/yandex-disk/deb/pool/main/y/yandex-disk/${PN}_${PV}_i386.deb )
        amd64?  ( http://repo.yandex.ru/yandex-disk/deb/pool/main/y/yandex-disk/${PN}_${PV}_amd64.deb )"
SLOT="0"
KEYWORDS="-* ~x86 ~amd64"
DEPEND=""
RDEPEND=""
IUSE=""

src_unpack() {
        mkdir "${S}"
        cd "${S}"
        if use amd64 ; then
                unpack ${PN}_${PV}_amd64.deb
        else
                unpack ${PN}_${PV}_i386.deb
        fi

        unpack ./data.tar.gz
}

src_install() {
        cp -pPR "${S}"/usr "${D}"/ || die "Installation failed."
}

pkg_postinst() {
        elog "Now you can configure Yandex.Disk client with command:"
        elog "yandex-disk setup"
}