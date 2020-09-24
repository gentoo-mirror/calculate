# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="threads(+)"

inherit autotools python-r1
MY_PN=dbus-python
MY_P=$MY_PN-$PV

DESCRIPTION="Python bindings for the D-Bus messagebus"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/DBusBindings https://dbus.freedesktop.org/doc/dbus-python/"
SRC_URI="https://dbus.freedesktop.org/releases/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~mips ppc ppc64 ~s390 sparc x86"

IUSE="examples"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"

RDEPEND="${PYTHON_DEPS}
	!dev-python/dbus-python[python_targets_python2_7]
	>=sys-apps/dbus-1.8:=
	>=dev-libs/glib-2.40
"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
"
S="${WORKDIR}/${MY_PN}-${PV}"

src_prepare() {
	default
	# Update py-compile, bug 529502.
	eautoreconf
	python_copy_sources
}

src_configure() {
	local SPHINX_IMPL=${EPYTHON}

	configuring() {
		local myconf=(
			--disable-documentation
		)
		[[ ${EPYTHON} == ${SPHINX_IMPL} ]] &&
			myconf+=( --enable-documentation )

		econf "${myconf[@]}"
	}
	python_foreach_impl run_in_build_dir configuring
}

src_compile() {
	python_foreach_impl run_in_build_dir default
}

src_test() {
	unset DBUS_SESSION_BUS_ADDRESS
	python_foreach_impl run_in_build_dir default
}

src_install() {
	python_foreach_impl run_in_build_dir default
	find "${D}" -name '*.la' -type f -delete || die
}

python_install_all() {
	distutils-r1_python_install_all
	rm -r ${D}/usr/share
}
