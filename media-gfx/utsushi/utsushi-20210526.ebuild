# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools eutils multilib toolchain-funcs udev

COMMIT="7d9d76ad783b567028ff06aa971d348447bd4b28"
DESCRIPTION="SANE backend driver for newer Epson scanners (DS, ET, PX, etc)"
HOMEPAGE="https://gitlab.com/utsushi/utsushi"
SRC_URI="https://gitlab.com/${PN}/${PN}/-/archive/${COMMIT}/${PN}-${COMMIT}.tar.gz -> ${PN}-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="gtk jpeg +network nls openmp tiff udev"

# These are needed by utsushi's 'bootstrap':
#   dev-libs/gnulib
#   sys-devel/autoconf-archive
#   sys-devel/autoconf-wrapper
#   sys-devel/automake-wrapper
#   sys-devel/gettext
#   sys-devel/libtool
#   sys-devel/patch
DEPEND="
	sys-devel/autoconf-archive
	sys-devel/autoconf-wrapper
	sys-devel/automake-wrapper
	sys-devel/gettext
	media-gfx/imagemagick
	media-gfx/sane-backends
	>=dev-libs/libusb-1.0.22
	>=dev-libs/boost-1.50.0
	gtk?          ( dev-cpp/gtkmm:2.4 )
	jpeg?         ( virtual/jpeg:0 )
	tiff?         ( media-libs/tiff:0= )
	udev?         ( virtual/udev )
"

RDEPEND="
	${DEPEND}
	network?     ( media-gfx/epson-ds-plugins )
"

PATCHES=(
	# Fixes building on boost 1.73
	#   https://bugs.gentoo.org/721696
	"${FILESDIR}/${PN}-uint.patch"
	"${FILESDIR}/${PN}-9999-boost-1.73.patch"
)

S="${WORKDIR}/${PN}-${COMMIT}"

src_prepare() {
	default

	sed -i "s/m4_esyscmd_s(\[git describe --always\])/${PV}/"  ${S}/configure.ac

	# utsushi requires using this bootstrap wrapper in lieu of autotools
	${S}/bootstrap || die

	# Create SANE configuration directory (used by sane/Makefile.am to create
	# utsushi backend config)
	dodir /etc/sane.d/dll.d
}

src_configure() {
	econf \
		--with-boost-system                         \
		--with-sane                                 \
		--with-sane-confdir="${EPREFIX}"/etc/sane.d \
		--with-magick                               \
		--with-magick-pp                            \
		$(use_with gtk gtkmm)                       \
		$(use_with jpeg)                            \
		$(use_enable nls)                           \
		$(use_enable openmp)                        \
		$(use_with tiff)                            \
		$(use_enable udev udev-config)              \
		$(use_with udev udev-confdir "$(get_udevdir)")
		#$(use_with udev udev-confdir "${EPREFIX}"/lib/udev)
}
