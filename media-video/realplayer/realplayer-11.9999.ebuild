# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit nsplugins eutils rpm

MY_PN="RealPlayer"
DESCRIPTION="Real Media Player"
HOMEPAGE="http://www.real.com/ http://player.helixcommunity.org/"
SRC_URI="http://forms.real.com/real/player/download.html?f=unix/RealPlayer11GOLD.rpm"
RESTRICT="mirror strip test"
LICENSE="HBRL"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="X nsplugin"

RDEPEND="!amd64? (
			X? ( >=dev-libs/glib-2
				>=x11-libs/pango-1.2
				>=x11-libs/gtk+-2.2 )
			=virtual/libstdc++-3.3*
		)
		amd64? (
			X? ( app-emulation/emul-linux-x86-gtklibs )
			app-emulation/emul-linux-x86-compat
		)"

QA_TEXTRELS="opt/RealPlayer/codecs/raac.so
	opt/RealPlayer/codecs/colorcvt.so
	opt/RealPlayer/codecs/drv2.so
	opt/RealPlayer/codecs/drvc.so
	opt/RealPlayer/plugins/theorarend.so
	opt/RealPlayer/plugins/vorbisrend.so
	opt/RealPlayer/plugins/swfrender.so
	opt/RealPlayer/plugins/oggfformat.so"

QA_EXECSTACK="opt/RealPlayer/plugins/swfrender.so
	opt/RealPlayer/plugins/vidsite.so
	opt/RealPlayer/codecs/raac.so
	opt/RealPlayer/codecs/drvc.so
	opt/RealPlayer/codecs/drv2.so
	opt/RealPlayer/codecs/colorcvt.so
	opt/RealPlayer/codecs/atrc.so"

QA_DT_HASH="opt/.*so opt/.*/realplay.bin"

MY_S="${WORKDIR}/opt/real/${MY_PN}"

pkg_setup() {
	# This is a binary x86 package => ABI=x86
	# Please keep this in future versions
	# Danny van Dyk <kugelfang@gentoo.org> 2005/03/26
	has_multilib_profile && ABI="x86"
}

src_unpack() {
	rpm_src_unpack
}

src_install() {
	dodir /opt/${MY_PN}

	cd "${MY_S}"

#	fperms 644 codecs/*
	insinto "/opt/${MY_PN}/codecs"
	doins codecs/*

	if use X; then

		rm "${MY_S}/share/distcode"

		# Make them executable, Bug #233415
		exeinto "/opt/${MY_PN}/"
		doexe realplay realplay.bin

		insinto "/opt/${MY_PN}/"
		for x in common mozilla plugins share; do
			doins -r "${MY_S}/${x}"
		done;

		domenu "${MY_S}/share/realplay.desktop"

		for res in 16 32 48 192; do
			insinto /usr/share/icons/hicolor/${res}x${res}/apps
			newins "${MY_S}/share/icons/realplay_${res}x${res}.png" \
					realplay.png
		done

		# mozilla plugin
		if use nsplugin ; then
			exeinto /opt/netscape/plugins
			doexe "${MY_S}/mozilla/nphelix.so"
			inst_plugin /opt/netscape/plugins/nphelix.so

			insinto /opt/netscape/plugins
			doins "${MY_S}/mozilla/nphelix.xpt"
			inst_plugin /opt/netscape/plugins/nphelix.xpt
		fi

		dodir /usr/bin
		dosym "/opt/${MY_PN}/realplay" /usr/bin/realplay
	fi

	# Language resources
	cd "${D}"/opt/RealPlayer/share/locale
	for LC in *; do
		mkdir -p "${D}"/usr/share/locale/${LC}/LC_MESSAGES
		dosym /opt/RealPlayer/share/locale/${LC}/player.mo /usr/share/locale/${LC}/LC_MESSAGES/realplay.mo
		dosym /opt/RealPlayer/share/locale/${LC}/widget.mo /usr/share/locale/${LC}/LC_MESSAGES/libgtkhx.mo
	done

	cd "${MY_S}"
	dodoc README
	dohtml share/hxplay_help.html share/tigris.css
}
