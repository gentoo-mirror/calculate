# Copyright open-overlay 2015 by Alex

EAPI="5"

GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2 versionator


MATE_BRANCH="$(get_version_component_range 1-2)"

SRC_URI="http://pub.mate-desktop.org/releases/${MATE_BRANCH}/${P}.tar.xz"
DESCRIPTION="MATE user-guide"
HOMEPAGE="http://mate-desktop.org"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="virtual/libintl:0"

DEPEND="${RDEPEND}
 	gnome-extra/yelp
        >=dev-util/intltool-0.40:*
	app-text/yelp-tools
	>=mate-base/mate-common-1.12:0
	sys-devel/gettext:*
	virtual/pkgconfig:*"

DOCS="AUTHORS ChangeLog NEWS README"
