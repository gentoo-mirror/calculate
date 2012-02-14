# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit versionator
MY_PN=${PN/-bin/}
C_PV=$(get_version_component_range 1-2)
DESCRIPTION="Flexible, easy to use and (really) fast static/dinamic menu generator for the Openbox Window Manager."
HOMEPAGE="https://launchpad.net/obmenugen"
SRC_URI="http://launchpad.net/${MY_PN}/${C_PV}/${PV}/+download/${MY_PN}-${PVR}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
		x11-wm/openbox"

S=${WORKDIR}/${MY_PN}-${PVR}

src_compile() {
echo done
}

src_install() {
	newbin ./bin/obmenugen obmenugen
	dodir /usr/share/obmenugen/
	cp -r ./translations/ ${D}/usr/share/obmenugen/
	dodoc README.txt LICENSE.txt
	}
