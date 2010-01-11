# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

ETYPE="sources"

KV_MAJOR=2
KV_MINOR=6
KV_PATCH=31
KV_TYPE=-calculate
GENTOO_SOURCES_PR="r9"
SYSTEM="desktop"

inherit calculate-kernel

DESCRIPTION="Desktop binary kernel including the Gentoo patchset for the 2.6 kernel tree"
HOMEPAGE="http://www.calculate-linux.org/linux-desktop"

LICENSE="GPL-2"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=">=sys-apps/calculate-1.3.3"
RDEPEND="${DEPEND}"
