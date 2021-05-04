# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )
WX_GTK_VER="3.0"

DISTUTILS_USE_SETUPTOOLS=manual
inherit alternatives distutils2 eutils flag-o-matic wxwidgets

ORIG_PN="wxpython"
MY_PN="wxPython-src"

DESCRIPTION="A blending of the wxWindows C++ class library with Python"
HOMEPAGE="http://www.wxpython.org/"
SRC_URI="
	mirror://sourceforge/wxpython/${MY_PN}-${PV}.tar.bz2"

LICENSE="wxWinLL-3"
SLOT="3.0"
KEYWORDS="~alpha amd64 arm arm64 ppc ppc64 ~sparc x86"
IUSE="cairo libnotify opengl"
RESTRICT="test"

RDEPEND="
	!dev-python/${ORIG_PN}[python_targets_python2_7]
	>=x11-libs/wxGTK-${PV}:${WX_GTK_VER}=[libnotify=,opengl?,tiff,X]
	dev-libs/glib:2
	dev-python/setuptools-python2[${PYTHON_USEDEP}]
	media-libs/libpng:0=
	media-libs/tiff:0
	virtual/jpeg
	x11-libs/gtk+:2
	x11-libs/pango[X]
	cairo?	( >=dev-python/pycairo-python2-1.8.4[${PYTHON_USEDEP}] )
	opengl?	( dev-python/pyopengl-python2[${PYTHON_USEDEP}] )"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/${MY_PN}-${PV}/wxPython"
DOC_S="${WORKDIR}/wxPython-${PV}"

# The hacky build system seems to be broken with out-of-source builds,
# and installs 'wx' package globally.
DISTUTILS_IN_SOURCE_BUILD=1

python_prepare_all() {
	sed -i "s:cflags.append('-O3'):pass:" config.py || die "sed failed"

	echo "DEBUG $S"
	cd "${S}"
	eapply "${FILESDIR}"/${ORIG_PN}-3.0.0.0-wxversion-scripts.patch
	eapply "${FILESDIR}"/${ORIG_PN}-2.8.11-drop-editra.patch
	eapply "${FILESDIR}"/${ORIG_PN}-2.8-no-preservatives-added.patch
	eapply "${FILESDIR}"/${ORIG_PN}-2.8.12.1-disable-egging-mode.patch

	distutils2_python_prepare_all
}

src_configure() {
	need-wxwidgets unicode

	mydistutilsargs=(
		WX_CONFIG="${WX_CONFIG}"
		WXPORT=gtk2
		UNICODE=1
		BUILD_GLCANVAS=$(usex opengl 1 0)
	)
}

python_compile() {
	# We need to have separate libdirs due to hackery, bug #455332.
	distutils2_python_compile \
		build --build-purelib "${BUILD_DIR}"/lib.common
}

python_install() {
	distutils2_python_install \
		build --build-purelib "${BUILD_DIR}"/lib.common

	# adjust the filenames for wxPython slots.
	local file
	for file in "${D}$(python_get_sitedir)"/wx{version.*,.pth}; do
		mv "${file}" "${file}-${SLOT}" || die
	done
	cd "${ED}"usr/lib/python-exec/"${EPYTHON}" || die
	for file in *; do
		mv "${file}" "${file}-${SLOT}" || die

		# wrappers are common to all impls, so a parallel run may
		# move it for us. ln+rm is more failure-proof.
		#ln -fs ../lib/python-exec/python-exec2 "${ED}usr/bin/${file}-${SLOT}" || die
		rm -f "${ED}usr/bin/${file}"
	done
}

python_install_all() {
	dodoc docs/{CHANGES,PyManual,README,wxPackage,wxPythonManual}.txt

	for x in {Py{AlaMode,Crust,Shell},XRCed}; do
		newmenu distrib/${x}.desktop ${x}-${SLOT}.desktop
	done
	newicon wx/py/PyCrust_32.png PyCrust-${SLOT}.png
	newicon wx/py/PySlices_32.png PySlices-${SLOT}.png
	newicon wx/tools/XRCed/XRCed_32.png XRCed-${SLOT}.png

	distutils2_python_install_all

	rm -r ${D}/usr/share
}

fdo-mime_desktop_database_update() {
	has "${EAPI:-0}" 0 1 2 && ! use prefix && EPREFIX=
	has "${EAPI:-0}" 0 1 2 && ! use prefix && EROOT="${ROOT}"
	if [ -x "${EPREFIX}/usr/bin/update-desktop-database" ]
	then
		einfo "Updating desktop mime database ..."
		"${EPREFIX}/usr/bin/update-desktop-database" -q "${EROOT}usr/share/applications"
	fi
}

pkg_postinst() {
	fdo-mime_desktop_database_update

	create_symlinks() {
		alternatives_auto_makesym "$(python_get_sitedir)/wx.pth" "$(python_get_sitedir)/wx.pth-[0-9].[0-9]"
		alternatives_auto_makesym "$(python_get_sitedir)/wxversion.py" "$(python_get_sitedir)/wxversion.py-[0-9].[0-9]"
	}
	python_foreach_impl create_symlinks

	echo
	elog "Gentoo uses the Multi-version method for SLOT'ing."
	elog "Developers, see this site for instructions on using"
	elog "it with your apps:"
	elog "http://wiki.wxpython.org/MultiVersionInstalls"
}

pkg_postrm() {
	fdo-mime_desktop_database_update

	update_symlinks() {
		alternatives_auto_makesym "$(python_get_sitedir)/wx.pth" "$(python_get_sitedir)/wx.pth-[0-9].[0-9]"
		alternatives_auto_makesym "$(python_get_sitedir)/wxversion.py" "$(python_get_sitedir)/wxversion.py-[0-9].[0-9]"
	}
	python_foreach_impl update_symlinks
}

