# Copyright open-overlay 2015 by Alex

EAPI=5

PLOCALES=" \
	af am ar ast be ber bg bn bs ca ckb csb cs cy da de el en_AU en_CA \
	en_GB eo es et eu fa fi fo fr gl gv he hi hr hu hy id is it ja jv kk \
	kn ko lt lv mk ml mr ms nb nds nl nn oc pa pl pt_BR pt ro ru si sk sl \
	sq sr sv ta te th tr uk ur vi zh_CN zh_HK zh_TW"

PYTHON_COMPAT=( python2_7 )

inherit eutils gnome2-utils python-single-r1 l10n

DESCRIPTION="MintMenu supports filtering, favorites, easy-uninstallation, autosession, and many other features."
MINT_TRANSLATIONS="mint-translations_2015.02.23.tar.gz"
LANG_URL="http://packages.linuxmint.com/pool/main/m/mint-translations/${MINT_TRANSLATIONS}"
SRC_URI="http://packages.linuxmint.com/pool/main/m/mintmenu/${PN}_${PV}.tar.gz ${LANG_URL}"
HOMEPAGE="http://linuxmint.com"
LICENSE="GPL-2"
KEYWORDS="amd64 x86"
SLOT="0"

RDEPEND="${PYTHON_DEPS}
	dev-python/python-xlib[${PYTHON_USEDEP}]
	dev-python/configobj[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	dev-python/pyxdg[${PYTHON_USEDEP}]
	|| ( x11-misc/mate-menu-editor[${PYTHON_USEDEP}]
		x11-misc/mozo[${PYTHON_USEDEP}] )
	mate-base/mate-panel[introspection]
	mate-base/mate-menus[python,${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_prepare() {
	# Install in correct libdir
	sed -e "s:/usr/lib:/usr/$(get_libdir):g" -i \
	mintmenu/usr/share/glib-2.0/schemas/com.linuxmint.mintmenu.gschema.xml \
	mintmenu/usr/bin/mintmenu || die
	# Correct for the correct locale path.
	sed -e "s:/usr/share/linuxmint/locale:/usr/share/locale:g" -i \
		mintmenu/usr/lib/linuxmint/mintMenu/mintMenuConfig.py \
		mintmenu/usr/lib/linuxmint/mintMenu/mintMenu.py \
		mintmenu/usr/lib/linuxmint/mintMenu/plugins/applications.py \
		mintmenu/usr/lib/linuxmint/mintMenu/plugins/system_management.py || die

	# Correct mate-folder.png -> folder.png
	sed -e "s:mate-folder.png:folder.png:g" -i \
		mintmenu/usr/lib/linuxmint/mintMenu/plugins/recent.py || die

	# Add shebang
	sed -e "1 i#!/usr/bin/env python" -i \
		mintmenu/usr/lib/linuxmint/mintMenu/keybinding.py \
		mintmenu/usr/lib/linuxmint/mintMenu/plugins/filemonitor.py \
		mintmenu/usr/lib/linuxmint/mintMenu/plugins/execute.py \
		mintmenu/usr/lib/linuxmint/mintMenu/plugins/__init__.py \
		mintmenu/usr/lib/linuxmint/mintMenu/plugins/recent.py || die

	# Correct location nautilus -> caja
	sed -e "s:/nautilus-:/caja-:g" -i \
		mintmenu/usr/lib/linuxmint/mintMenu/plugins/applications.py || die

	python_fix_shebang .
}

my_locale_install() {
	dodir /usr/share/linuxmint/locale/${1}/LC_MESSAGES
	insinto /usr/share/linuxmint/locale/${1}/LC_MESSAGES
	doins mint-translations-*/usr/share/linuxmint/locale/${1}/LC_MESSAGES/mintmenu.mo
}

src_install() {
	dobin mintmenu/usr/bin/mintmenu
	dodir /usr/$(get_libdir)/linuxmint/
	cp -R mintmenu/usr/lib/linuxmint/* ${D}/usr/$(get_libdir)/linuxmint/ || die
	dodir /usr/share/
	cp -R mintmenu/usr/share/* ${D}/usr/share/
	dodoc mintmenu/debian/changelog

	python_optimize ${ED}/usr/bin/mintmenu
	python_optimize ${ED}/usr/lib64/linuxmint/mintMenu
	python_optimize ${ED}/usr/lib64/linuxmint/mintMenu/plugins

	l10n_for_each_locale_do my_locale_install
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
        echo 
        elog "Please report bugs mintmenu on my email:a.xarlanov29@gmail.com"
        elog "Thanks open-overlay 2015 by Alex"
        echo
}

pkg_postrm() {
	gnome2_schemas_update
}
