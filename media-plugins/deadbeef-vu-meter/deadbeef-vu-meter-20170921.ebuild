# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

DEADBEEF_GUI="yes"

inherit deadbeef-plugins

GITHUB_COMMIT="77930b490bbedb2c56a246075894ec26ae07c38f"

DESCRIPTION="DeaDBeeF vu meter plugin"
HOMEPAGE="https://github.com/cboxdoerfer/ddb_vu_meter"
SRC_URI="https://github.com/cboxdoerfer/ddb_vu_meter/archive/${GITHUB_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/ddb_vu_meter-${GITHUB_COMMIT}"

src_compile() {
	use gtk2 && emake gtk2
	use gtk3 && emake gtk3
}
