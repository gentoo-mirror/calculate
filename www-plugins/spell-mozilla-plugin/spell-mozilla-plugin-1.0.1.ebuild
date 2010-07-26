# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="Spell check: plugin for mozilla firefox"
HOMEPAGE="http://addons.mozilla.org/ru/firefox/addon/3414"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="x86 amd64"

PLUGIN_UID="dictionary-switcher@design-noir.de"
PLUGIN_PN="dictionary_switcher"
PLUGIN_BUILD="3414"

SWITCHER_FN="dictionary_switcher-1.0.1-fx.xpi"
SPELL_RU_FN="russian_spellchecking_dictionary-0.4.3-fx+tb+sm.xpi"
SPELL_EN_FN="united_states_english_dictionary-4.0.0-fx+tb+sm.xpi"
SPELL_DE_FN="w__rterbuch_deutsch__de-de___hunspell-unterst__tzt-20091006-fx+tb+sm+fn.xpi"
SPELL_UK_FN="ukrainian_dictionary-1.6.0-fx+tb.xpi"
SPELL_PTBR_FN="verifica_ccedil_atilde_o_ortogr_aacute_fica_pt-br-1.0.0.1-fx+zm+tb.xpi"
SPELL_PL_FN="polski_slownik_poprawnej_pisowni-1.0.20091103-fx+tb+sm.xpi"
SPELL_IT_FN="dizionario_italiano-3.1-fx+tb+sm.xpi"
SPELL_ES_FN="diccionario_de_espa__ol_espa__a-1.3.0-fx+tb+sm+sb+fn.xpi"
SPELL_FR_FN="dictionnaire_fran__ais___r__forme_1990__-3.5-fx+tb+sm.xpi"

IUSE=""
LANGS="en de es fr pt_BR it pl ru uk"
for x in ${LANGS}; do
	IUSE="${IUSE} linguas_${x}"
done

SRC_URI="http://releases.mozilla.org/pub/mozilla.org/addons/${PLUGIN_BUILD}/${SWITCHER_FN}
		ftp://ftp.calculate.ru/pub/calculate/${PN}/${SWITCHER_FN}
		http://releases.mozilla.org/pub/mozilla.org/addons/3497/${SPELL_EN_FN}
		ftp://ftp.calculate.ru/pub/calculate/${PN}/${SPELL_EN_FN}
		linguas_ru? ( 
			http://releases.mozilla.org/pub/mozilla.org/addons/3703/${SPELL_RU_FN} 
			ftp://ftp.calculate.ru/pub/calculate/${PN}/${SPELL_RU_FN} )
		linguas_de? (
			http://releases.mozilla.org/pub/mozilla.org/addons/9361/${SPELL_DE_FN}
			ftp://ftp.calculate.ru/pub/calculate/${PN}/${SPELL_DE_FN} )
		linguas_uk? (
			http://releases.mozilla.org/pub/mozilla.org/addons/4782/${SPELL_UK_FN}
			ftp://ftp.calculate.ru/pub/calculate/${PN}/${SPELL_UK_FN} )
		linguas_pt_BR? (
			http://releases.mozilla.org/pub/mozilla.org/addons/3257/${SPELL_PTBR_FN}
			ftp://ftp.calculate.ru/pub/calculate/${PN}/${SPELL_PTBR_FN} )
		linguas_pl? (
			http://releases.mozilla.org/pub/mozilla.org/addons/3052/${SPELL_PL_FN}
			ftp://ftp.calculate.ru/pub/calculate/${PN}/${SPELL_PL_FN} )
		linguas_it? (
			http://releases.mozilla.org/pub/mozilla.org/addons/3053/${SPELL_IT_FN}
			ftp://ftp.calculate.ru/pub/calculate/${PN}/${SPELL_IT_FN} )
		linguas_es? (
			http://releases.mozilla.org/pub/mozilla.org/addons/3554/${SPELL_ES_FN}
			ftp://ftp.calculate.ru/pub/calculate/${PN}/${SPELL_ES_FN} )
		linguas_fr? (
			http://releases.mozilla.org/pub/mozilla.org/addons/13372/${SPELL_FR_FN}
			ftp://ftp.calculate.ru/pub/calculate/${PN}/${SPELL_ES_FN} )"

RDEPEND="www-client/firefox"

file_to_uid() {
	case $1 in
		$SWITCHER_FN) echo "${PLUGIN_UID}" ;;
		$SPELL_RU_FN) echo "ru@dictionaries.addons.mozilla.org" ;;
		$SPELL_EN_FN) echo "en-US@dictionaries.addons.mozilla.org" ;;
		$SPELL_DE_FN) echo "de_DE@dicts.j3e.de" ;;
		$SPELL_UK_FN) echo "uk-ua@dictionaries.addons.mozilla.org" ;;
		$SPELL_PTBR_FN) echo "pt-BR@dictionaries.addons.mozilla.org" ;;
		$SPELL_PL_FN)  echo "pl@dictionaries.addons.mozilla.org" ;;
		$SPELL_IT_FN) echo "it-IT@dictionaries.addons.mozilla.org" ;;
		$SPELL_ES_FN) echo "es-es@dictionaries.addons.mozilla.org" ;;
		$SPELL_FR_FN) echo "fr-reforme1990@dictionaries.addons.mozilla.org" ;;

		*) die "Unknown filename";;
	esac
}

src_unpack() {
	for f in ${A}
	do
		cd ${WORKDIR}
		local dir=$( file_to_uid $f )
		mkdir ${WORKDIR}/$dir
		cd ${WORKDIR}/$dir
		unzip "${DISTDIR}/${f}"
	done
	# fix version for some plugins
	sed -ri "s/3\.6a1pre/3.7a1pre/" "${WORKDIR}/$( file_to_uid ${SPELL_RU_FN})/install.rdf"
	sed -ri "s/3\.6a1/3.7a1/" "${WORKDIR}/$( file_to_uid ${SPELL_UK_FN})/install.rdf"
	sed -ri "s/3\.0a1/3.7a1/" "${WORKDIR}/$( file_to_uid ${SPELL_IT_FN})/install.rdf"
	sed -ri "s/2\.0\.0\.\*/3.7a1/" "${WORKDIR}/$( file_to_uid ${SPELL_PTBR_FN})/install.rdf"
}

src_install() {
	cd ${WORKDIR}
	insinto /usr/lib/mozilla-firefox/extensions/
	doins -r *
}
