# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

ETYPE="sources"

inherit calculate-kernel-2 eutils

DESCRIPTION="Full sources including the Calculate patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
KEYWORDS="~amd64 ~x86"
HOMEPAGE="http://www.calculate-linux.org"

SRC_URI="${KERNEL_URI} ${ARCH_URI} ${CALC_URI}"

UNIPATCH_LIST="${DISTDIR}/${PN}-${CKV}.tar.bz2"

DEPEND="vmlinuz? ( >=sys-kernel/calckernel-3.4.10.903-r23
	sys-apps/calculate-builder
	|| ( app-arch/xz-utils app-arch/lzma-utils )
	sys-apps/v86d )"

IUSE="bfq bfs"

src_unpack() {
	calculate-kernel-2_src_unpack

	# apply patch bfq
	if use bfq
	then
		epatch "${FILESDIR}/4700_BFQ_2.6.35.patch" || \
			die "Failed apply bfq patch"
	fi
	# apply patch bfs
	if use bfs
	then
		epatch "${FILESDIR}/4600_sched-bfs_2.6.35.patch" || \
			die "Failed apply bfs patch"
	fi
}

pkg_postinst() {
	calculate-kernel-2_pkg_postinst
	if use bfq
	then
		einfo "Change value of elevator to bfq in /boot/grub/grub.conf for"
		einfo "using BFQ I/O scheduler."
		einfo "Part of grub.conf for example:"
		einfo "kernel /boot/vmlinuz-a7acd396 root=/dev/sda2 elevator=bfq"
	fi
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}
