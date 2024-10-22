# Copyright 2007-2024 Mir Calculate
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Passman - The password manager for NextCloud / ownCloud (Chrome plugin)"
HOMEPAGE="https://passman.cc/ https://chrome.google.com/webstore/detail/hlpjhlifkgmoibhollggngbbhbejecph"
SRC_URI="https://mirror.calculate-linux.org/source/${PN}/${P}.tar.bz2"

S="${WORKDIR}"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="dev-python/plyvel
	dev-python/sjcl"

src_install() {
	insinto /usr/share/${PN}
	doins -r * .*
	doins "${FILESDIR}"/configure.py
	fperms 755 /usr/share/$PN/configure.py
}
