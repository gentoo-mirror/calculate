# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EXTENSION_NAME="org.openoffice.languagetool.oxt"

DESCRIPTION="Extension of OpenOffice to check grammar."
HOMEPAGE="http://extensions.services.openoffice.org/project/Languagetool"
SRC_URI="http://www.languagetool.org/download/LanguageTool-${PV}.oxt"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=app-office/openoffice-3.0.1[java]"
RDEPEND="${DEPEND}"

OOPATH="/usr/lib/openoffice"
OOEXTENSIONS="${OOPATH}/share/extension/install"

isinstall()
{
	if unopkg list --shared | grep "Identifier: ${EXTENSION_NAME}">/dev/null;
	then
		return 0;
	else
		return 1;
	fi
}

src_install()
{
	mkdir -p ${D}/${OOEXTENSIONS}
	cp ${DISTDIR}/LanguageTool-${PV}.oxt ${D}/${OOEXTENSIONS}/
}

pkg_postinst()
{
	if isinstall;
	then
		unopkg remove --shared ${EXTENSION_NAME}
	fi
	unopkg add --shared ${OOEXTENSIONS}/LanguageTool-${PV}.oxt 2>&1 | 
		grep "ERROR" >/dev/null && die "Can not install LanguageTool-${PV}"
}

pkg_prerm()
{
	if isinstall;
	then
		unopkg remove --shared ${EXTENSION_NAME} 2>&1 | 
			grep "ERROR" >/dev/null && die "Can not uninstall LanguageTool-${PV}"
	fi
}
