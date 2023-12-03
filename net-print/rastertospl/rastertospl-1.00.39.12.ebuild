# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DESCRIPTION="Proprietary plugins and software for HPLIP"
HOMEPAGE="https://ftp.hp.com"
SRC_URI="https://ftp.hp.com/pub/softlib/software13/printers/CLP150/uld-hp_V1.00.39.12_00.15.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

DEPEND="net-print/hplip"
RDEPEND="${DEPEND}"
BDEPEND=""
S="$WORKDIR/uld"
src_unpack() {
	[[ ! -n ${P}.tar.gz ]] ||  unpack ${P}.tar.gz
}

pkg_preinst() {
	set -e

	for binary in smfpnetdiscovery rastertospl pstosecps; do
		dobin "${S}/x86_64/$binary"
	done

	dolib.so "${S}/x86_64/libscmssc.so"

	cp -a "${S}/noarch/share/ppd/cms/" /usr/share/ppd/HP

	for ppd in \
		HP_Color_Laser_15x_Series.ppd \
		HP_Color_Laser_MFP_17x_Series.ppd \
		HP_Laser_10x_Series.ppd \
		HP_Laser_MFP_13x_Series.ppd
	do
		gzip -c "${S}/noarch/share/ppd/$ppd" > "/usr/share/ppd/HP/$ppd.gz"
	done

	dosym -r /usr/bin/smfpnetdiscovery /usr/libexec/cups/backend/smfpnetdiscovery
	dosym -r /usr/bin/pstosecps /usr/libexec/cups/filter/pstosecps
	dosym -r /usr/bin/rastertospl /usr/libexec/cups/filter/rastertospl

}
