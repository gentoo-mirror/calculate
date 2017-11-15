# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit deadbeef-plugins

GITHUB_COMMIT="224c2cf3371c4e0b68b1531fc1cb9983739cda69"

DESCRIPTION="DeaDBeeF bs2b dsp plugin"
HOMEPAGE="https://github.com/Alexey-Yakovenko/bs2b"
SRC_URI="https://github.com/Alexey-Yakovenko/bs2b/archive/${GITHUB_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"

RDEPEND+=" media-libs/libbs2b:0"

DEPEND="${RDEPEND}"

S="${WORKDIR}/bs2b-${GITHUB_COMMIT}"
