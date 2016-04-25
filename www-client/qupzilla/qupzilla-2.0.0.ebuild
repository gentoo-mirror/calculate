# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
KEYWORDS="~amd64 ~arm ~ppc64 ~x86"

MY_PN="QupZilla"
MY_P=${MY_PN}-${PV}

PLOCALES="ar_SA bg_BG ca_ES cs_CZ de_DE el_GR es_ES es_MX es_VE eu_ES fa_IR fi_FI fr_FR gl_ES he_IL hu_HU id_ID it_IT ja_JP ka_GE lg lv_LV nl_NL nqo pl_PL pt_BR pt_PT ro_RO ru_RU sk_SK sr@ijekavianlatin sr@ijekavian sr@latin sr sv_SE tr_TR uk_UA uz@Latn zh_CN zh_TW"
PLUGINS_HASH="7b037cc326921cefbfc6b5e54e2091eb4191e73f"
PLUGINS_VERSION="2015.10.15" # if there are no updates, we can use the older archive


inherit eutils l10n multilib qmake-utils vcs-snapshot

DESCRIPTION="Qt WebKit web browser"
HOMEPAGE="http://www.qupzilla.com/"
SRC_URI="https://github.com/${MY_PN}/${PN}/releases/download/v${PV}/${MY_P}.tar.xz
	https://github.com/${MY_PN}/${PN}-plugins/archive/${PLUGINS_HASH}.tar.gz -> ${PN}-plugins-${PLUGINS_VERSION}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
IUSE="dbus debug kde nonblockdialogs"
KEYWORDS="~amd64 ~arm ~ppc64 ~x86"

DEPEND="
	dev-lang/python:2.7[xml]
        >=dev-qt/qtcore-5.6.0
        >=dev-qt/qtgui-5.6.0
        >=dev-qt/qtconcurrent-5.6.0
        >=dev-qt/qtprintsupport-5.6.0
        >=dev-qt/qtscript-5.6.0
        >=dev-qt/qtsql-5.6.0[sqlite]
        >=dev-qt/qtwebengine-5.6.0[widgets]
 		>=dev-qt/qtdeclarative-5.6.0[widgets]
		>=dev-qt/qtx11extras-5.6.0
		app-text/hunspell
		media-plugins/gst-plugins-libav:1.0
		media-libs/gst-plugins-good:1.0
        dbus? ( >=dev-qt/qtdbus-5.6.0 )"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS BUILDING CHANGELOG FAQ README.md )
S=${WORKDIR}/${MY_P}

src_prepare() {
	rm_loc() {
		sed -i -e "/${1}.ts/d" translations/translations.pri || die
		rm translations/${1}.ts || die
	}
	# remove outdated copies of localizations:
	rm -r bin/locale || die
	# remove empty locale
	rm translations/empty.ts || die

	l10n_find_plocales_changes "translations" "" ".ts"
	l10n_for_each_disabled_locale_do rm_loc
}

src_configure() {
        export \
                QUPZILLA_PREFIX="${EPREFIX}/usr/" \
                USE_LIBPATH="${EPREFIX}/usr/$(get_libdir)" \
                USE_QTWEBKIT_2_2=true \
                DISABLE_DBUS=$(usex dbus '' 'true') \
                KDE_INTEGRATION=$(usex kde 'true' '') \
                NONBLOCK_JS_DIALOGS=$(usex nonblockdialogs 'true' '')
	eqmake5
}

src_install() {
        emake INSTALL_ROOT="${D}" install
        einstalldocs
}
