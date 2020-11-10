# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit autotools eutils multilib virtualx

DESCRIPTION="Tk-based Calendar program"
HOMEPAGE="https://launchpad.net/ical-tcl"
SRC_URI="https://launchpad.net/ical-tcl/3.x/${PV}/+download/${P}.tar.gz"

LICENSE="HPND"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="
	dev-lang/tcl:0
	dev-lang/tk:0
	"
DEPEND="${RDEPEND}"

S=${WORKDIR}/ical-tcl

src_prepare() {

#	sed -i \
#		-e 's:mkdir:mkdir -p:' \
#		-e '/MANDIR =/s:man:share/man:' \
#		Makefile.in || die

	eautoconf
}

src_compile() {
	emake OPTF="${CFLAGS}" CXXFLAGS="${CXXFLAGS}"
}

src_test() {
	[[ ${EUID} != 0 ]] && Xemake check
}

src_install() {
	emake DESTDIR="${D}" install
	
	DOCS=( *README )
	einstalldocs

	rm -f "${D}"/usr/$(get_libdir)/ical/v3.0/contrib/README || die
}
