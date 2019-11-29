# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit multilib flag-o-matic toolchain-funcs

DESCRIPTION="xfs dump/restore utilities"
HOMEPAGE="https://xfs.wiki.kernel.org/"
SRC_URI="https://git.kernel.org/pub/scm/fs/xfs/xfsdump-dev.git/snapshot/xfsdump-dev-1b1ecdaa215bbd44b21947ad4f12a2f4d3e0c975.tar.gz
	-> xfsdump-dev-2019.5.20.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="ncurses nls"

RDEPEND="
	>=sys-apps/attr-2.4.19
	sys-apps/dmapi
	sys-apps/util-linux
	sys-fs/e2fsprogs
	>=sys-fs/xfsprogs-5.3.0
	ncurses? ( sys-libs/ncurses:0= )
"
DEPEND="${RDEPEND}
	nls? (
		sys-devel/gettext
		elibc_uclibc? ( dev-libs/libintl )
	)"

S="${WORKDIR}/xfsdump-dev-1b1ecdaa215bbd44b21947ad4f12a2f4d3e0c975"

PATCHES=(
	"${FILESDIR}"/${PN}-2019.5.20-prompt-overflow.patch #335115
	"${FILESDIR}"/${PN}-2019.5.20-no-symlink.patch #311881
	"${FILESDIR}"/${PN}-3.1.6-linguas.patch #561664
	"${FILESDIR}"/${PN}-2019.5.20-compat-with-xfsprogs-5.3.0-and-up.patch # 693296
)

src_prepare() {
	make configure

	sed -i \
		-e "/^PKG_DOC_DIR/s:@pkg_name@:${PF}:" \
		include/builddefs.in \
		|| die

	sed -i \
		-e "s:enable_curses=[a-z]*:enable_curses=$(usex ncurses):" \
		-e "s:libcurses=\"[^\"]*\":libcurses='$(use ncurses && $(tc-getPKG_CONFIG) --libs ncurses)':" \
		configure || die #605852

	default
}

src_configure() {
	unset PLATFORM #184564
	export OPTIMIZER=${CFLAGS}
	export DEBUG=-DNDEBUG

	local myeconfargs=(
		$(use_enable nls gettext)
		--libdir="${EPREFIX}/$(get_libdir)"
		--libexecdir="${EPREFIX}/usr/$(get_libdir)"
		--sbindir="${EPREFIX}/sbin"
	)
	econf "${myeconfargs[@]}"
}

src_compile() {
	# enable verbose build
	emake V=1
}
