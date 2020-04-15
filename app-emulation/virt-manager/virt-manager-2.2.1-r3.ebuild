# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7} )
DISTUTILS_SINGLE_IMPL=1

inherit gnome2 distutils-r1

DESCRIPTION="A graphical tool for administering virtual machines"
HOMEPAGE="http://virt-manager.org"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	SRC_URI=""
	KEYWORDS="amd64 x86"
	EGIT_REPO_URI="https://github.com/virt-manager/virt-manager.git"
else
	SRC_URI="http://virt-manager.org/download/sources/${PN}/${P}.tar.gz"
	KEYWORDS="amd64 ~ppc64 x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="gtk policykit sasl"

RDEPEND="!app-emulation/virtinst
	${PYTHON_DEPS}
	app-cdr/cdrtools
	>=app-emulation/libvirt-glib-1.0.0[introspection]
	$(python_gen_cond_dep '
		dev-libs/libxml2[python,${PYTHON_MULTI_USEDEP}]
		dev-python/ipaddr[${PYTHON_MULTI_USEDEP}]
		dev-python/libvirt-python[${PYTHON_MULTI_USEDEP}]
		dev-python/pygobject:3[${PYTHON_MULTI_USEDEP}]
		dev-python/requests[${PYTHON_MULTI_USEDEP}]
	')
	>=sys-libs/libosinfo-0.2.10[introspection]
	gtk? (
		gnome-base/dconf
		>=net-libs/gtk-vnc-0.3.8[gtk3(+),introspection]
		net-misc/spice-gtk[usbredir,gtk3,introspection,sasl?]
		net-misc/x11-ssh-askpass
		x11-libs/gtk+:3[introspection]
		x11-libs/gtksourceview:4[introspection]
		x11-libs/vte:2.91[introspection]
		policykit? ( sys-auth/polkit[introspection] )
	)
"
DEPEND="${RDEPEND}
	dev-lang/perl
	dev-util/intltool
"

DOCS=( README.md NEWS.md )

src_prepare() {
	distutils-r1_src_prepare
}

distutils-r1_python_compile() {
	local defgraphics=

	esetup.py configure \
		--default-graphics=spice
}

virtmanager_python_install() {
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

src_install() {
	local mydistutilsargs=( --no-update-icon-cache --no-compile-schemas )
	virtmanager_python_install

	python_fix_shebang "${ED}"/usr/share/virt-manager
}

pkg_preinst() {
	if use gtk; then
		gnome2_pkg_preinst

		cd "${ED}"
		export GNOME2_ECLASS_ICONS=$(find 'usr/share/virt-manager/icons' -maxdepth 1 -mindepth 1 -type d 2> /dev/null)
	else
		rm -rf "${ED}/usr/share/virt-manager/virtManager"
		rm -f "${ED}/usr/share/virt-manager/virt-manager"
		rm -rf "${ED}/usr/share/virt-manager/ui/"
		rm -rf "${ED}/usr/share/virt-manager/icons/"
		rm -rf "${ED}/usr/share/man/man1/virt-manager.1*"
		rm -rf "${ED}/usr/share/icons/"
		rm -rf "${ED}/usr/share/applications/virt-manager.desktop"
		rm -rf "${ED}/usr/bin/virt-manager"
	fi
}

pkg_postinst() {
	use gtk && gnome2_pkg_postinst
}
