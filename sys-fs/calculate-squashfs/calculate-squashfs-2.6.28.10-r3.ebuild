# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils flag-o-matic linux-info toolchain-funcs linux-mod

# versions as
SQUASH_PV="squashfs3.4"
LZMA_PV="lzma457"
SQ_PV=${SQUASH_PV/#squashfs}
SQLZMA_PV="sqlzma${SQ_PV}-${LZMA_PV/#lzma}"

get_kernel_version_from_pv() {
	[[ ${PV} =~ ([0-9]+)\.([0-9]+)\.([0-9]+)\.?([0-9]+)? ]]
	# version kernel
	KV_MAJOR=${BASH_REMATCH[1]}
	KV_MINOR=${BASH_REMATCH[2]}
	KV_PATCH=${BASH_REMATCH[3]}
	KV_TYPE=${BASH_REMATCH[4]}
	OKV="${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}"
	KV_LOCAL="-calculate"
}

get_kernel_version_from_pv

DESCRIPTION="Tool for creating compressed filesystem type squashfs"
HOMEPAGE="http://squashfs.sourceforge.net http://www.squashfs-lzma.org"
SRC_URI="mirror://kernel/linux/kernel/v${KV_MAJOR}.${KV_MINOR}/patch-${OKV}.${KV_TYPE}.bz2
	 mirror://kernel/linux/kernel/v${KV_MAJOR}.${KV_MINOR}/linux-${OKV}.tar.bz2
	 mirror://sourceforge/squashfs/${SQUASH_PV}.tar.gz
	 mirror://sourceforge/sevenzip/${LZMA_PV}.tar.bz2
	 ftp://ftp.slax.org/source/slax/sqlzma/${SQUASH_PV}.tar.gz
	 ftp://ftp.slax.org/source/slax/sqlzma/${SQLZMA_PV}.tar.bz2"

IUSE=""

DEPEND="=sys-kernel/calculate-sources-${OKV}.${KV_TYPE}"

RDEPEND="!sys-fs/squashfs-tools"

LICENSE="GPL-2 LGPL-2.1"
SLOT="2.6.28.10"
KEYWORDS="~amd64 ~x86"
BUILD_TARGETS="all"
[[ ${ARCH} == "amd64" ]] && ARCH="x86_64"
BUILD_TARGET_ARCH="${ARCH}"
MODULE_NAMES="sqlzma(kernel/fs/squashfs:.) squashfs(kernel/fs/squashfs:.) unlzma(kernel/fs/squashfs:.)"

pkg_setup() {
	if kernel_is lt 2 6 28; then
		eerror
		eerror "${P} needs kernel 2.6.28 or above."
		eerror
		die "Upgrade kernel"
	fi
	linux-mod_pkg_setup

	get_kernel_version_from_pv
	KV_FULL="${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}.${KV_TYPE}${KV_LOCAL}"
	append-ldflags -Wl,--no-as-needed
}

src_unpack() {
	cd "${WORKDIR}"
	unpack ${SQLZMA_PV}.tar.bz2 || die
	unpack ${SQUASH_PV}.tar.gz || die
	unpack linux-${OKV}.tar.bz2 || die
	unpack patch-${OKV}.${KV_TYPE}.bz2 || die
	mkdir ${LZMA_PV}
	cd ${LZMA_PV}
	unpack ${LZMA_PV}.tar.bz2 || die
	cd ../linux-${OKV}
	epatch ../patch-${OKV}.${KV_TYPE} || die
	epatch ../${SQUASH_PV}/kernel-patches/linux-2.6.27-rc4/${SQUASH_PV}-patch || die
	epatch ../sqlzma2k-${SQ_PV}.patch  || die
	if kernel_is ge 2 6 28; then
		epatch "${FILESDIR}"/squashfs-linux-${OKV}.patch || die
		sed -i "s:EXTRAVERSION = .${KV_TYPE}:EXTRAVERSION = .${KV_TYPE}${KV_LOCAL}:" Makefile|| die
		sed -i "s:KVer = linux-2.6.27.4:KVer = linux-${OKV}:" ../Makefile|| die
	fi
	cd ../${SQUASH_PV}
	epatch ../sqlzma2u-${SQ_PV}.patch || die
	cd ..
	epatch sqlzma1-${LZMA_PV/#lzma}.patch || die
	ln -s ../../linux-${OKV} ${SQUASH_PV}/kernel-patches
	if [ -e ${KV_OUT_DIR}/.config ]
	then
		cp ${KV_OUT_DIR}/.config linux-${OKV}
	else
		die "Not found ${KV_OUT_DIR}/.config"
	fi
	cd linux-${OKV}
	sed -i "/^CONFIG_SQUASHFS=/d" .config|| die
	sed -i "/^CONFIG_SQUASHFS_EMBEDDED=/d" .config|| die
	sed -i "/^CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=/d" .config|| die
	echo CONFIG_SQUASHFS=m >> .config
	echo CONFIG_SQUASHFS_EMBEDDED=n >> .config
	echo CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3 >> .config
	make oldconfig
	make prepare
	make scripts
}
#
src_compile() {
	emake CC="$(tc-getCC)" || die
	mkdir BUILD
	cp ./linux-${OKV}/fs/squashfs/squashfs.ko BUILD
	cp ./${LZMA_PV}/C/Compress/Lzma/kmod/sqlzma.ko BUILD
	cp ./${LZMA_PV}/C/Compress/Lzma/kmod/unlzma.ko BUILD
	cp ./${SQUASH_PV}/squashfs-tools/unsquashfs BUILD/unsquashfs-${PV}
	cp ./${SQUASH_PV}/squashfs-tools/mksquashfs BUILD/mksquashfs-${PV}
	strip --strip-unneeded BUILD/mksquashfs-${PV} BUILD/unsquashfs-${PV}
}
# 
src_install() {
	cd BUILD
	dobin mksquashfs-${PV} unsquashfs-${PV} || die
	linux-mod_src_install
}

pkg_postinst() {
	linux-mod_pkg_postinst
	KV_FULL=""
	get_version
	if [[ -f /usr/bin/mksquashfs-${KV_FULL/-calculate} ]];
	then
		rm -f /usr/bin/mksquashfs
		ln -sf /usr/bin/mksquashfs-${KV_FULL/-calculate} /usr/bin/mksquashfs
	fi
	if [[ -f /usr/bin/unsquashfs-${KV_FULL/-calculate} ]];
	then
		rm -f /usr/bin/unsquashfs
		ln -sf /usr/bin/unsquashfs-${KV_FULL/-calculate} /usr/bin/unsquashfs
	fi
}
