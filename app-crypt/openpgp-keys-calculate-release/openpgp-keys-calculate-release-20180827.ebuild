# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="OpenPGP keys used for Calculate binary packages"
HOMEPAGE="http://www.calculate-linux.org"
SRC_URI="https://mirror.calculate-linux.org/source/openpgp-keys/calculate-release.asc.${PV}.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 x86"

S=${WORKDIR}

src_install() {
	insinto /usr/share/openpgp-keys
	newins "calculate-release.asc.${PV}" calculate-release.asc
}
