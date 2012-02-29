# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

DESCRIPTION="A lightweight calendar designed for tint2"
HOMEPAGE="http://code.google.com/p/gsimplecal/"
SRC_URI="http://gsimplecal.googlecode.com/files/${P}.tar.gz"

LICENSE="The BSD 2-Clause License"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/libunique:3
	x11-libs/gtk+:2
	>=sys-devel/autoconf-2.65"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${P}"

src_configure() {
	cd ${S}
	./configure
	econf
}

src_install() {
	emake DESTDIR="${D}" install
}
