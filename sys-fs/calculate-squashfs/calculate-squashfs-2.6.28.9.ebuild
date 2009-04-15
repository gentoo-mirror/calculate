# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit eutils flag-o-matic linux-info toolchain-funcs linux-mod

# versions as
SQUASH_PV="squashfs3.4"
LZMA_PV="lzma457"
SQ_PV=${SQUASH_PV/#squashfs}
SQLZMA_PV="sqlzma${SQ_PV}-${LZMA_PV/#lzma}"

[[ ${PV} =~ ([0-9]+)\.([0-9]+)\.([0-9]+)\.?([0-9]+)? ]]
# version kernel
KV_MAJOR=${BASH_REMATCH[1]}
KV_MINOR=${BASH_REMATCH[2]}
KV_PATCH=${BASH_REMATCH[3]}
KV_TYPE=${BASH_REMATCH[4]}
OKV="${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}"

DESCRIPTION="Tool for creating compressed filesystem type squashfs" 
HOMEPAGE="http://squashfs.sourceforge.net http://www.squashfs-lzma.org"
SRC_URI="mirror://kernel/linux/kernel/v${KV_MAJOR}.${KV_MINOR}/patch-${OKV}.${KV_TYPE}.bz2
	 mirror://kernel/linux/kernel/v${KV_MAJOR}.${KV_MINOR}/linux-${OKV}.tar.bz2
	 mirror://sourceforge/squashfs/${SQUASH_PV}.tar.gz
	 mirror://sourceforge/sevenzip/${LZMA_PV}.tar.bz2
	 ftp://ftp.slax.org/source/slax/sqlzma/${SQUASH_PV}.tar.gz
	 ftp://ftp.slax.org/source/slax/sqlzma/${SQLZMA_PV}.tar.bz2"

DEPEND="=sys-kernel/calculate-sources-${OKV}.${KV_TYPE}"

RDEPEND="!sys-fs/squashfs-tools"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
BUILD_TARGETS="all"
[[ ${ARCH} == "amd64" ]] && ARCH="x86_64"
BUILD_TARGET_ARCH="${ARCH}"
MODULE_NAMES="sqlzma(kernel/fs/squashfs:.) squashfs(kernel/fs/squashfs:.) unlzma(kernel/fs/squashfs:.)"

pkg_setup() {
	if kernel_is lt 2 6 24; then
		eerror
		eerror "${P} needs kernel 2.6.24 or above."
		eerror
		die "Upgrade kernel"
	fi
	linux-mod_pkg_setup
	append-ldflags -Wl,--no-as-needed
}

src_unpack() {
	cd ${WORKDIR}
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
		sed -i "s:EXTRAVERSION = .9:EXTRAVERSION = .${KV_TYPE}-calculate:" Makefile|| die
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
	cp ./${SQUASH_PV}/squashfs-tools/unsquashfs BUILD
	cp ./${SQUASH_PV}/squashfs-tools/mksquashfs BUILD
	strip --strip-unneeded BUILD/mksquashfs BUILD/unsquashfs
}
# 
src_install() {
	cd BUILD
	dobin mksquashfs unsquashfs || die
	linux-mod_src_install
}
