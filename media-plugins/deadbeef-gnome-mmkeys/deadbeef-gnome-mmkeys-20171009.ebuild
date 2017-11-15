# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit deadbeef-plugins

GITHUB_COMMIT="c0da8e4fbfb2fb584916cf1ea4895fecbea1ac23"

DESCRIPTION="DeaDBeeF gnome (via dbus) multimedia keys plugin"
HOMEPAGE="https://github.com/barthez/deadbeef-gnome-mmkeys"
SRC_URI="https://github.com/barthez/${PN}/archive/${GITHUB_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

RDEPEND+=" sys-apps/dbus:0"

S="${WORKDIR}/${PN}-${GITHUB_COMMIT}"
