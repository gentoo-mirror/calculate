# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit rpm

S="${WORKDIR}"

DESCRIPTION="Non-free network plugin package for Epson DS line of scanners"
HOMEPAGE="http://download.ebz.epson.net/dsc/search/01/search/?OSC=LX"
#SRC_URI="https://download2.ebz.epson.net/imagescanv3/centos/latest1/rpm/x64/imagescan-bundle-centos-7-${PV}.x64.rpm.tar.gz"
SRC_URI="https://download2.ebz.epson.net/imagescanv3/centos/latest2/rpm/x64/imagescan-bundle-centos-7-${PV}.x64.rpm.tar.gz"

RESTRICT="nomirror"

LICENSE="COPYING.EPSON"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="
	${DEPEND}
	media-gfx/utsushi
"

# EPSON provided closed-source binary
QA_PRESTRIPPED="usr/libexec/utsushi/networkscan"

src_unpack() {
	# Create a 'core' and 'plugins' directory to unpack into
	mkdir -p "${WORKDIR}/"{core,plugins}

	# Unpack top-level package
	unpack "$A"

	# Unpack the core drivers to the created 'core' directory
	cd "${WORKDIR}/core"
	rpm_unpack ./../imagescan-bundle-centos-7-${PV}.x64.rpm/core/imagescan-*.rpm

	# Unpack 'networkscan' plugin to the created 'plugins' directory
	cd "${WORKDIR}/plugins"
	rpm_unpack ./../imagescan-bundle-centos-7-${PV}.x64.rpm/plugins/imagescan-plugin-networkscan*.rpm
}

#
# The udev rules are not installed as it's handled by the 'utsushi' source
# package.
#
# The 'utsushi' config file for SANE (/etc/sane.d/dll.d/utsushi) is handled by
# the 'utsushi' source package
#
src_install() {
	# Create a subdirectory to install the 'networkscan' docs
	dodoc ${WORKDIR}/plugins/usr/share/doc/imagescan-plugin-networkscan-*/{README,NEWS}

	# Install the 'networkscan' config files
	# Renamed config to 'utsushi.conf' to be picked up by utsushi SANE backend
	insinto /etc/utsushi
	newins ${WORKDIR}/core/etc/imagescan/imagescan.conf utsushi.conf

	# Install the 'networkscan' binary
	exeinto /usr/libexec/utsushi
	doexe ${WORKDIR}/plugins/usr/libexec/utsushi/networkscan
}

pkg_postinst() {
	elog
	elog "Remember to insert your scanner information into:"
	elog "  /etc/utsushi/utsushi.conf"
	elog
	elog "See /usr/share/doc/${PF}/README.bz2 for examples"
	elog
}
