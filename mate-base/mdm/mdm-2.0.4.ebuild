#Copyright open-overlay 2015 by Alex

EAPI=5

inherit autotools eutils libtool gnome2 pam user 
DESCRIPTION="Mate Display Manager"
HOMEPAGE="http://mate-desktop.org"
LICENSE="GPL-2 LGPL-2"
SLOT=0
KEYWORDS="~amd64 ~arm ~x86"
GDM_EXTRA="gdm-2.8-gentoo-files-r2"
SRC_URI="https://github.com/linuxmint/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
        http://mirror.yandex.ru/gentoo-distfiles/distfiles/${GDM_EXTRA}.tar.bz2"
IUSE="accessibility afs elibc_glibc remote gnome-keyring ipv6 xinerama pam tcpd dmx selinux +consolekit"


RDEPEND="
        dev-libs/glib:2
	x11-libs/gtk+:2
	>=x11-libs/pango-1.36.8
        x11-libs/gdk-pixbuf
	gnome-base/libglade:2.0
	gnome-base/libgnomecanvas
	gnome-base/librsvg:2
	dev-libs/libxml2:2
	media-libs/libart_lgpl
	net-libs/webkit-gtk:2
	x11-libs/gksu
	x11-libs/libXi
	x11-libs/libXau
	x11-libs/libX11
	x11-libs/libXext
	x11-apps/sessreg
	x11-libs/libXdmcp
	xinerama? ( x11-libs/libXinerama x11-proto/xineramaproto )
	consolekit? (
		sys-auth/consolekit
		dev-libs/dbus-glib )
	accessibility? ( x11-libs/libXevie )
	afs? ( net-fs/openafs sys-libs/lwp )
	dmx? ( x11-libs/libdmx )
	gnome-keyring? ( gnome-base/gnome-keyring[pam] )
	pam? ( virtual/pam )
	!pam? ( elibc_glibc? ( sys-apps/shadow ) )
	remote? ( gnome-extra/zenity )
	selinux? ( sys-libs/libselinux )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )
	>=x11-misc/xdg-utils-1.0.2-r3
"

DEPEND="${RDEPEND}
	dmx? ( x11-proto/dmxproto )
	app-text/docbook-xml-dtd:4.1.2
	sys-devel/gettext
	x11-proto/inputproto
	>=dev-util/intltool-0.35
	virtual/pkgconfig
	>=app-text/scrollkeeper-0.1.4
	>=app-text/gnome-doc-utils-0.3.2"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README TODO"
	G2CONF="${G2CONF}
		--with-prefetch
		--sysconfdir=/etc/X11
		--localstatedir=/var
		--with-pam-prefix=/etc
         	--disable-static
		$(use_enable ipv6)
		$(use_enable remote secureremote)
		$(use_with accessibility xevie)
		$(use_with consolekit console-kit)
		$(use_with dmx)
		$(use_with selinux)
		$(use_with tcpd tcp-wrappers)
		$(use_with xinerama)"

	if use pam; then
		G2CONF="${G2CONF} --enable-authentication-scheme=pam"
	else
		G2CONF="${G2CONF} --enable-console-helper=no"
		if use elibc_glibc ; then
			G2CONF="${G2CONF} --enable-authentication-scheme=shadow"
		else
			G2CONF="${G2CONF} --enable-authentication-scheme=crypt"
		fi
	fi

	enewgroup mdm
	enewuser mdm -1 -1 /var/lib/mdm mdm
}

src_prepare() {
	eautoreconf

	gnome2_src_prepare
}

src_install() {
        gnome2_src_install

	local gentoodir="${WORKDIR}/${GDM_EXTRA}"

	# install XDG_DATA_DIRS mdm changes
	echo 'XDG_DATA_DIRS="/usr/share/mdm"' > 99xdg-mdm
	doenvd 99xdg-mdm


	# avoid file collision, bug #213118
	rm -f "${D}/usr/share/xsessions/gnome.desktop"

	# We replace the pam stuff by our own
	rm -rf "${D}/etc/pam.d"

	if use pam ; then
		use gnome-keyring && sed -i "s:#Keyring=::g" "${gentoodir}"/pam.d/*

		mv "${gentoodir}"/pam.d/{g,m}dm
		mv "${gentoodir}"/pam.d/{g,m}dmsetup
		mv "${gentoodir}"/pam.d/{g,m}dm-autologin
		dopamd "${gentoodir}"/pam.d/*
		sed s/gdmsetup/mdmsetup/ "${gentoodir}/security/console.apps/gdmsetup" > "${gentoodir}/security/console.apps/mdmsetup"
		dopamsecurity console.apps "${gentoodir}/security/console.apps/mdmsetup"
	fi

}
