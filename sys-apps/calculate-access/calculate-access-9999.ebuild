# Copyright 2008-2024 Mir Calculate
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Cryptodata management tools for Calculate"
HOMEPAGE="https://www.calculate-linux.org"
EGIT_REPO_URI="https://git.calculate-linux.org/calculate/calculate-access.git"

inherit git-r3

LICENSE="Apache-2.0"
SLOT="0"
IUSE="+client server"
REQUIRED_USE="|| ( client server )"

src_install() {
	if use client
	then
		DESTDIR="$D" emake install_client
	fi

	if use server
	then
		DESTDIR="$D" emake install_server
	fi
}
