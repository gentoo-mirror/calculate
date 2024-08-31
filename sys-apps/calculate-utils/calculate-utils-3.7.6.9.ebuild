# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools

PYTHON_COMPAT=( python3_{11..13} )

DESCRIPTION="A set of Calculate utilities for system installation, build and upgrade"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate_utilities"

LICENSE="Apache-2.0"
SLOT="3"

inherit distutils-r1

export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_BRANCH="master"
	EGIT_REPO_URI="https://git.calculate-linux.org/calculate/calculate-utils.git"
else
	SRC_URI="https://git.calculate-linux.org/calculate/calculate-utils/archive/${PV}.tar.gz -> calculate-utils-${PV}.tar.gz"
	if [[ ${PR} == "r0" ]]; then
		KEYWORDS="amd64"
	else
		KEYWORDS="~amd64"
	fi
	S="${WORKDIR}/${PN}"
fi

IUSE="backup client console dbus desktop +gpg +install minimal pxe qt5"
distutils_enable_tests unittest

CALCULATE_MODULES_=(
	"core"
	"builder"
	"update"
	"i18n"
	"lib"
	"install"
)

declare -g -A CALCULATE_MODULES_USE_=(
	["console-gui"]="qt5"
	["desktop"]="desktop"
	["client"]="client"
	["console"]="console"
)

python_prepare_all() {
	distutils-r1_python_prepare_all

	local core_file_path="src/calculate/core/wsdl_core.py"
	if ! use backup; then
		sed -ir "s/'cl-backup'/None/" $core_file_path
		sed -ir "s/'cl-backup-restore'/None/" $core_file_path
		sed -ir "s/__('Backup')/None/g" $core_file_path

		einfo "Do something with calculate/core/wsdl_core.py"
	fi

	local lib_file_path="src/calculate/lib/variables/__init__.py"
	sed -ri "/class VariableClVer/{N;N;N;N;s/value = \".*?\"/value = \"${PV}\"/;}" \
		$lib_file_path || die
	einfo "Change version in $lib_file_path => $PV"

	use_flags=()
	for exc_module in ${!CALCULATE_MODULES_USE_[@]}; do
		use_flag=${CALCULATE_MODULES_USE_[$exc_module]}
		if ! use $use_flag; then
			[[ $exc_module == "console-gui" ]] && exc_module="consolegui"
			remove_path="src/calculate/${exc_module}"
			rm -rf ${remove_path} || die "Can't remove module from path: ${remove_path}"
			elog "Module calculate.${exc_module} removed."
		else
			[[ $exc_module == "console-gui" ]] && use_flag="console-gui"
			use_flags+=(${use_flag})
		fi
	done
	use_flags=${use_flags[@]}

	cat >> setup.cfg <<-EOF

	[use_flags]
	flags = ${use_flags// /,}
	EOF
}

python_configure() {
	esetup.py build_mo
}

python_configure_all() {
	if use dbus; then
		DISTUTILS_ARGS=(install_data --uses dbus)
	fi
}

python_install() {
	if use qt5; then
		local scriptdir=${EPREFIX}/usr/bin
		local root=${BUILD_DIR}/install
		local reg_scriptdir=${root}/${scriptdir}

		python_newscript ${reg_scriptdir}/cl-console-gui cl-console-gui-install
		python_newscript ${reg_scriptdir}/cl-console-gui cl-console-gui-update
	fi

	distutils-r1_python_install

	keepdir /var/log/calculate
}

python_install_all() {
	debug-print-function ${FUNCNAME} "${@}"
	_distutils-r1_check_all_phase_mismatch
}

pkg_preinst() {
	mv ${D}/usr/etc ${D}/ || die "Can't find /usr/etc directory"
	einfo "mv files from ${D}/usr/etc to ${D}/"

	mkdir ${D}/bin || die
	mv ${D}/usr/bin/bashlogin ${D}/bin || die
	einfo "Change path for bashlogin script."
	einfo "from ${D}/usr/bin/bashlogin to ${D}/bin"

	mv ${D}/usr/usr/* ${D}/usr && rm -rf ${D}/usr/usr/
	einfo "mv files from /usr/usr/ to /usr and remove /usr/usr"

	keepdir /etc/calculate

	dosym /usr/libexec/calculate/cl-core-wrapper /usr/bin/cl-core-setup
	dosym /usr/libexec/calculate/cl-core-wrapper /usr/bin/cl-core-patch
	dosym /usr/libexec/calculate/cl-core-wrapper /usr/bin/cl-update
	dosym /usr/libexec/calculate/cl-core-wrapper /usr/bin/cl-update-profile
}

RDEPEND="
	dev-libs/libbsd
	install? ( >=app-cdr/cdrtools-3.01_alpha13
		>=sys-boot/grub-2.00-r3
		>=sys-boot/syslinux-5
		sys-fs/squashfs-tools
		sys-fs/dosfstools
		sys-block/parted
		sys-apps/gptfdisk
		sys-fs/lvm2
		sys-fs/mdadm
	)
	!minimal? (
		>=sys-apps/util-linux-2.19.1
		net-misc/rsync
		dev-python/pyopenssl[${PYTHON_USEDEP}]
		dev-python/cryptography[${PYTHON_USEDEP}]
		dev-python/cffi[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}]
		dev-libs/openssl
		dev-python/m2crypto[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}]
	)
	gpg? (
		app-crypt/gnupg
		app-crypt/openpgp-keys-calculate-release
	)
	dev-python/jaraco-functools[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/aiohttp
	sys-apps/iproute2[-minimal]
	sys-apps/pciutils
	app-arch/xz-utils
	app-portage/eix
	app-portage/portage-utils

	sys-apps/debianutils
	sys-kernel/installkernel

	app-eselect/eselect-repository
	>=virtual/udev-197
	!app-misc/livecd-tools
	sys-apps/coreutils[xattr]

	pxe? ( sys-apps/calculate-server
		net-ftp/tftp-hpa
		net-misc/dhcp
		net-fs/nfs-utils
	)

	!<sys-apps/calculate-server-2.1.18-r1

	qt5? (
		dev-python/dbus-python[${PYTHON_USEDEP}]
		media-gfx/imagemagick[jpeg]
		dev-python/PyQt5[${PYTHON_USEDEP}]
		dev-python/pyinotify[${PYTHON_USEDEP}]
	)

	dbus? (
		dev-python/dbus-python[${PYTHON_USEDEP}]
	)

	dev-python/pexpect[${PYTHON_USEDEP}]

	desktop? (
		media-gfx/feh
		x11-apps/xmessage
		sys-apps/keyutils
		sys-auth/pam_keystore
		dev-lang/swig
		dev-qt/qdbus
		sys-apps/edid-decode
		dev-python/pygobject[${PYTHON_USEDEP}]
		dev-python/dbus-python[${PYTHON_USEDEP}]
	)

	client? (
		dev-python/python-ldap[ssl,${PYTHON_USEDEP}]
		sys-auth/pam_client
		>=sys-auth/pam_ldap-180[ssl]
		>=sys-auth/nss_ldap-239
	)
	backup? ( !sys-apps/calculate-server )
"
#	server? (
#		sys-auth/pam_ldap
#		sys-auth/nss_ldap
#		dev-python/python-ldap[${PYTHON_USEDEP}]
#	)
#
#
#	server? ( !sys-apps/calculate-server )

DEPEND="
	sys-devel/gettext"

#REQUIRED_USE="client? ( desktop )"
