# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/claws-mail-themes/claws-mail-themes-20120129.ebuild,v 1.2 2012/05/20 09:46:48 fauli Exp $

DESCRIPTION="Iconset Calculate for Claws Mail"
HOMEPAGE="http://www.claws-mail.org/"
SRC_URI="http://www.claws-mail.org/download.php?file=themes/png/claws-mail-theme_Tango_1.2.1.tar.gz"

LICENSE="CCPL-Attribution-ShareAlike-2.5 as-is"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 x86"
IUSE=""

RDEPEND="mail-client/claws-mail"
DEPEND=""

src_install(){
	insinto /usr/share/claws-mail/themes
	mv Tango_v1.2.1 Calculate
	doins -r Calculate
}
