# Copyright 1999-2024 Gentoo Authors, 2007-2024 Mir Calculate
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

MY_PN=libjpeg-turbo

DESCRIPTION="MMX, SSE, and SSE2 SIMD accelerated JPEG library"
HOMEPAGE="https://libjpeg-turbo.org/ https://sourceforge.net/projects/libjpeg-turbo/"
SRC_URI="https://github.com/libjpeg-turbo/libjpeg-turbo/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	mirror://gentoo/libjpeg8_8d-2.debian.tar.gz"

S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="BSD IJG ZLIB"
SLOT="0/0.2"
if [[ $(ver_cut 3) -lt 90 ]] ; then
	KEYWORDS="~alpha amd64 ~arm ~arm64 ~hppa ~loong ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86 ~amd64-linux ~x86-linux"
fi
IUSE="cpu_flags_arm_neon"

ASM_DEPEND="|| ( dev-lang/nasm dev-lang/yasm )"
BDEPEND="
	amd64? ( ${ASM_DEPEND} )
	x86? ( ${ASM_DEPEND} )
	amd64-linux? ( ${ASM_DEPEND} )
	x86-linux? ( ${ASM_DEPEND} )
"

MULTILIB_WRAPPED_HEADERS=( /usr/include/jconfig.h )

src_prepare() {
	local FILE
	ln -snf ../debian/extra/*.c . || die

	for FILE in ../debian/extra/*.c; do
		FILE=${FILE##*/}
		cat >> CMakeLists.txt <<EOF || die
add_executable(${FILE%.c} ${FILE})
install(TARGETS ${FILE%.c})
EOF
	done

	cmake_src_prepare
}

src_configure() {

	local mycmakeargs=(
		-DCMAKE_BUILD_WITH_INSTALL_RPATH=ON
		-DCMAKE_INSTALL_DEFAULT_DOCDIR="${EPREFIX}/usr/share/doc/${PF}"
		-DENABLE_SHARED=ON
		-DENABLE_STATIC=OFF
		-DWITH_JAVA=OFF
		-DWITH_JPEG8=1
		-DWITH_MEM_SRCDST=ON
	)

	# Avoid ARM ABI issues by disabling SIMD for CPUs without NEON, bug #792810
	if use arm || use arm64; then
		mycmakeargs+=(
			-DWITH_SIMD=$(usex cpu_flags_arm_neon)
			-DNEON_INTRINSICS=$(usex cpu_flags_arm_neon)
		)
	fi

	# We should tell the test suite which floating-point flavor we are
	# expecting: https://github.com/libjpeg-turbo/libjpeg-turbo/issues/597
	# For now, mark loong as fp-contract.
	if use loong; then
		mycmakeargs+=(
			-DFLOATTEST=fp-contract
		)
	fi

	# mostly for Prefix, ensure that we use our yasm if installed and
	# not pick up host-provided nasm
	if has_version -b dev-lang/yasm && ! has_version -b dev-lang/nasm; then
		mycmakeargs+=(
			-DCMAKE_ASM_NASM_COMPILER=$(type -P yasm)
		)
	fi

	cmake_src_configure
}

src_install() {
	insinto /usr/lib64/
	doins "${WORKDIR}/libjpeg-turbo-${PV}_build/libjpeg.so.8.2.2"
	doins "${WORKDIR}/libjpeg-turbo-${PV}_build/libjpeg.so.8"
}
