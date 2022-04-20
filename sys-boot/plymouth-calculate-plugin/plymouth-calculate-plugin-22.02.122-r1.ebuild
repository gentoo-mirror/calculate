# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

MY_P=plymouth-${PV}
MY_PN=plymouth

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.freedesktop.org/plymouth/plymouth"
else
	SRC_URI="${SRC_URI} https://www.freedesktop.org/software/plymouth/releases/${MY_P}.tar.xz"
	KEYWORDS="~alpha amd64 arm arm64 ~ia64 ppc ~ppc64 ~riscv sparc x86"
fi

S="${WORKDIR}/${MY_P}"

inherit autotools readme.gentoo-r1 systemd

DESCRIPTION="Graphical boot animation (splash) and logger"
HOMEPAGE="https://cgit.freedesktop.org/plymouth/"

LICENSE="GPL-2"
SLOT="0"
IUSE="debug +drm +gtk +pango +split-usr static-libs +udev"

CDEPEND="
	>=media-libs/libpng-1.2.16:=
	drm? ( x11-libs/libdrm )
	gtk? (
		dev-libs/glib:2
		>=x11-libs/gtk+-3.14:3
		x11-libs/cairo
	)
	pango? ( >=x11-libs/pango-1.21 )
"
DEPEND="${CDEPEND}
	elibc_musl? ( sys-libs/rpmatch-standalone )
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt
	virtual/pkgconfig
"
# Block due bug #383067
RDEPEND="${CDEPEND}
	udev? ( virtual/udev )
	!<sys-kernel/dracut-0.37-r3
"

DOC_CONTENTS="
	Follow the following instructions to set up Plymouth:\n
	https://wiki.gentoo.org/wiki/Plymouth#Configuration
"

PATCHES=(
	"${FILESDIR}"/0.9.3-glibc-sysmacros.patch
)

src_prepare() {
	use elibc_musl && append-ldflags -lrpmatch
	default
	cp ${FILESDIR}/0.9.6_pre20211225-plugin.c ${S}/src/plugins/splash/two-step/plugin.c
	sed -i 's/two-step/calculate/g' ${S}/src/plugins/splash/two-step/Makefile.*
	sed -i 's/two_step/calculate/g' ${S}/src/plugins/splash/two-step/Makefile.*
	eautoreconf
}

src_configure() {
	local myconf=(
		--with-system-root-install=no
		--localstatedir=/var
		--without-rhgb-compat-link
		--enable-documentation
		--enable-systemd-integration
		--with-systemdunitdir="$(systemd_get_systemunitdir)"
		$(use_enable !static-libs shared)
		$(use_enable static-libs static)
		$(use_enable debug tracing)
		$(use_enable drm)
		$(use_enable gtk)
		$(use_enable pango)
		$(use_with udev)
	)
	econf "${myconf[@]}"
}

src_compile() {
	cd src/libply
	emake
	cd ../libply-splash-core
	emake
	cd ../libply-splash-graphics
	emake
	cd ../plugins/splash/two-step
	emake
}

# src_install() {
# 	default

# 	insinto /usr/share/plymouth
# 	newins "${DISTDIR}"/gentoo-logo.png bizcom.png

# 	if use split-usr ; then
# 		# Install compatibility symlinks as some rdeps hardcode the paths
# 		dosym ../usr/bin/plymouth /bin/plymouth
# 		dosym ../usr/sbin/plymouth-set-default-theme /sbin/plymouth-set-default-theme
# 		dosym ../usr/sbin/plymouthd /sbin/plymouthd
# 	fi

# 	readme.gentoo_create_doc

# 	# looks like make install create /var/run/plymouth
# 	# this is not needed for systemd, same should hold for openrc
# 	# so remove
# 	rm -rf "${D}"/var/run

# 	# fix broken symlink
# 	dosym ../../bizcom.png /usr/share/plymouth/themes/spinfinity/header-image.png
# }

src_install() {
	cd ${S}/src/plugins/splash/two-step
	emake DESTDIR="${D}" install

	cd ${S}/themes/spinfinity

	insinto /usr/share/plymouth/themes/calculate
	doins box.png bullet.png entry.png lock.png

	cd ${S}/themes/spinner
	doins throbber-00*.png

	newins ${FILESDIR}/0.9.6_pre20211225-calculate.plymouth calculate.plymouth
}
