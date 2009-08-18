# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

MY_P=${PV}-u4-b5
MY_F=mac-${MY_P}
DESCRIPTION="Monkey Audio Codec  (MAC linux port)"
HOMEPAGE="http://sourceforge.net/projects/mac-port/"
SRC_URI="mirror://sourceforge/mac-port/$MY_F.tar.gz
	http://195.113.31.123/~sanda/mac/$MY_F.tar.gz"

LICENSE="MAC"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${MY_F}.tar.gz || die "unpacking failed"
	cd "${WORKDIR}"
	mv ${MY_F} ${P}
}

src_compile() {
	econf || die "econf failed"
	emake || die "make failed"
}

src_install() {
	einstall || die "install failed"
	dodoc AUTHORS README AUTHORS src/License.htm NEWS ChangeLog
}
