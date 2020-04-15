# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=no
PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1 xdg-utils

DESCRIPTION="A frontend for find, (s)locate, doodle, tracker, beagle, strigi and pinot"
HOMEPAGE="https://docs.xfce.org/apps/catfish/start"
SRC_URI="https://archive.xfce.org/src/apps/catfish/${PV%.*}/${P}.tar.bz2"

# yep, GPL-2 only
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"

RDEPEND="
	dev-libs/gobject-introspection
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/pexpect[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	x11-libs/gdk-pixbuf[introspection]
	x11-libs/gtk+:3[introspection]
	x11-libs/pango[introspection]
	virtual/freedesktop-icon-theme
"
BDEPEND="
	dev-python/python-distutils-extra[${PYTHON_USEDEP}]
	sys-devel/gettext
"

catfish_python_install() {
	debug-print-function ${FUNCNAME} "${@}"

	local args=( "${@}" )

	# enable compilation for the install phase.
	local -x PYTHONDONTWRITEBYTECODE=

	# python likes to compile any module it sees, which triggers sandbox
	# failures if some packages haven't compiled their modules yet.
	addpredict "${EPREFIX}/usr/lib/${EPYTHON}"
	addpredict "${EPREFIX}/usr/$(get_libdir)/${EPYTHON}"
	addpredict /usr/lib/pypy2.7
	addpredict /usr/lib/pypy3.6
	addpredict /usr/lib/portage/pym
	addpredict /usr/local # bug 498232

	if [[ ! ${DISTUTILS_SINGLE_IMPL} ]]; then
		# user may override --install-scripts
		# note: this is poor but distutils argv parsing is dumb
		local mydistutilsargs=( "${mydistutilsargs[@]}" )
		local scriptdir=${EPREFIX}/usr/bin

		# construct a list of mydistutilsargs[0] args[0] args[1]...
		local arg arg_vars
		[[ ${mydistutilsargs[@]} ]] && eval arg_vars+=(
			'mydistutilsargs['{0..$(( ${#mydistutilsargs[@]} - 1 ))}']'
		)
		[[ ${args[@]} ]] && eval arg_vars+=(
			'args['{0..$(( ${#args[@]} - 1 ))}']'
		)

		set -- "${arg_vars[@]}"
		while [[ ${@} ]]; do
			local arg_var=${1}
			shift
			local a=${!arg_var}

			case "${a}" in
				--install-scripts=*)
					scriptdir=${a#--install-scripts=}
					unset "${arg_var}"
					;;
				--install-scripts)
					scriptdir=${!1}
					unset "${arg_var}" "${1}"
					shift
					;;
			esac
		done
	fi

	local root=${D%/}/_${EPYTHON}
	[[ ${DISTUTILS_SINGLE_IMPL} ]] && root=${D%/}

	esetup.py install --root="${root}" "${args[@]}"

	local forbidden_package_names=( examples test tests .pytest_cache )
	local p
	for p in "${forbidden_package_names[@]}"; do
		if [[ -d ${root}$(python_get_sitedir)/${p} ]]; then
			die "Package installs '${p}' package which is forbidden and likely a bug in the build system."
		fi
	done

	local shopt_save=$(shopt -p nullglob)
	shopt -s nullglob
	local pypy_dirs=(
		"${root}/usr/$(get_libdir)"/pypy*/share
		"${root}/usr/lib"/pypy*/share
	)
	${shopt_save}

	if [[ -n ${pypy_dirs} ]]; then
		die "Package installs 'share' in PyPy prefix, see bug #465546."
	fi

	if [[ ! ${DISTUTILS_SINGLE_IMPL} ]]; then
		_distutils-r1_wrap_scripts "${root}" "${scriptdir}"
		multibuild_merge_root "${root}" "${D%/}"
	fi
}

python_install() {
	catfish_python_install
	python_optimize
	rm -r "${ED}"/usr/share/doc/catfish || die
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
