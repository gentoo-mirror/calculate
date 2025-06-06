# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="C++ bindings for Apache Thrift"
HOMEPAGE="https://thrift.apache.org/lib/cpp.html"
SRC_URI="mirror://apache/thrift/${PV}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0/0"
KEYWORDS="amd64"
IUSE="libevent lua +ssl test"

RESTRICT="!test? ( test )"

DEPEND="
	dev-libs/boost:=[nls]
	dev-libs/openssl:=
	libevent? ( dev-libs/libevent )
"
RDEPEND="${DEPEND}"

REQUIRED_USE="
	test? ( ssl )
"

PATCHES=(
	"${FILESDIR}/thrift-0.16.0-network-tests.patch"
)

src_configure() {
	local mycmakeargs=(
		-DBUILD_CPP=ON
		-DBUILD_C_GLIB=OFF
		-DBUILD_JAVA=OFF
		-DBUILD_JAVASCRIPT=OFF
		-DBUILD_NODEJS=OFF
		-DBUILD_PYTHON=OFF
		-DBUILD_TESTING=$(usex test 'ON' 'OFF')
		-DWITH_LIBEVENT=$(usex libevent 'ON' 'OFF')
		-DWITH_OPENSSL=$(usex ssl 'ON' 'OFF')
		-DWITH_ZLIB=ON
		-DWITH_QT5=OFF
		-Wno-dev
	)
	cmake_src_configure
}
