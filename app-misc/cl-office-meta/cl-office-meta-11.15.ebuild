# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Linux (office meta package)"
HOMEPAGE="http://www.calculate-linux.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="cdistro_CLD cdistro_CLDG cdistro_CLDX linguas_de linguas_en linguas_es linguas_fr linguas_it linguas_pt_BR linguas_ru"

RDEPEND="
	app-editors/vim
	app-office/libreoffice
	app-text/fbreader

	cdistro_CLD? (
		app-text/goldendict
		kde-misc/openofficeorg-thumbnail
	)
	cdistro_CLDG? (
		app-text/stardict
	)
	cdistro_CLDX? (
		!app-editors/mousepad
		app-editors/leafpad
		app-text/evince
		app-text/stardict
		sci-calculators/galculator
	)

	linguas_de? (
		app-dicts/aspell-de
		app-dicts/ispell-de
		app-dicts/myspell-de
	)
	linguas_en? (
		app-dicts/aspell-en
		app-dicts/myspell-en
	)
	linguas_es? (
		app-dicts/aspell-es
		app-dicts/ispell-es
		app-dicts/myspell-es
	)
	linguas_fr? (
		app-dicts/aspell-fr
		app-dicts/ispell-fr
		app-dicts/myspell-fr
	)
	linguas_it? (
		app-dicts/aspell-it
		app-dicts/ispell-it
		app-dicts/myspell-it
	)
	linguas_pt_BR? (
		app-dicts/aspell-pt-br
		app-dicts/ispell-pt-br
		app-dicts/myspell-pt
	)
	linguas_ru? (
		app-dicts/aspell-ru
		app-dicts/ispell-ru
		app-dicts/myspell-ru
	)
"

