# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# @ECLASS: calculate-utils.eclass
# @MAINTAINER:
# support@calculate.ru
# @AUTHOR:
# Author: Mir Calculate
# @DESCRIPTION:
# This eclass use for calculate-utils ebuild

PYTHON_COMPAT=(python2_7)

inherit distutils-r1 eutils versionator

EXPORTED_FUNCTIONS="src_compile src_install pkg_postinst pkg_preinst"

CALCULATE_URI="ftp://ftp.calculate.ru/pub/calculate/calculate3"
MIRROR_URI="http://mirror.yandex.ru/calculate/calculate3"

# @ECLASS-VARIABLE: CALCULATE_MODULES
# @DESCRIPTION:
# Associative array module names and versions
# Example:
# declare -A CALCULATE_MODULES=(
#   ["console-gui"]="3.2.3.4"
# )

# @ECLASS-VARIABLE: CALCULATE_MODULES_USE
# @DESCRIPTION:
# Associative array module names and use for IUSE
# Example:
# declare -A CALCULATE_MODULES_USE=(
#   ["console-gui"]=""
# )

# @ECLASS-VARIABLE: CALCULATE_TARBALL
# @DESCRIPTION:
# Associative array module names and tarball archive name
# Example:
# declare -A CALCULATE_TARBALL=( ["lib"]="calculate-lib-3.2.3-r1.tar.bz2" )

# @ECLASS-VARIABLE: UTILS_PV
# @DESCRIPTION:
# Default version of all components
# Example:
: ${UTILS_PV:=$(get_version_component_range 1-3 ${PV})}

declare -A CALCULATE_TARBALL_=()

declare -A CALCULATE_MODULES_=(
	["lib"]="$UTILS_PV"
	["builder"]="$UTILS_PV"
	["install"]="$UTILS_PV"
	["core"]="$UTILS_PV"
	["i18n"]="$UTILS_PV"
	["update"]="$UTILS_PV"
	["desktop"]="$UTILS_PV"
	["client"]="$UTILS_PV"
	["console-gui"]="$UTILS_PV"
	["console"]="$UTILS_PV")

declare -A CALCULATE_MODULES_USE_=(
	["desktop"]="desktop"
	["client"]="client"
	["console-gui"]="qt4"
	["console"]="console"
)

EXPORT_FUNCTIONS ${EXPORTED_FUNCTIONS}

# @FUNCTION: prepare_variables
# @DESCRIPTION:
# Prepare variables for ebuild
prepare_variables() {
	for module in ${!CALCULATE_MODULES[@]}
	do
		CALCULATE_MODULES_[$module]=${CALCULATE_MODULES[$module]}
	done

	for module in ${!CALCULATE_MODULES_USE[@]}
	do
		CALCULATE_MODULES_USE_[$module]=${CALCULATE_MODULES_USE[$module]}
	done

	for module in ${!CALCULATE_MODULES_[@]}
	do
		MODULE_PN=calculate-${module}
		MODULE_PV=${CALCULATE_MODULES_[$module]}
		if [[ -n ${CALCULATE_TARBALL[$module]} ]]
		then
			CALCULATE_TARBALL_[$module]="${MODULE_PN}/${CALCULATE_TARBALL[$module]}"
		else
			CALCULATE_TARBALL_[$module]="${MODULE_PN}/${MODULE_PN}-${MODULE_PV}.tar.bz2"
		fi
	done

	MODULE_INFO=()
	for module in ${!CALCULATE_MODULES_[@]}
	do
		MODULE_USE=${CALCULATE_MODULES_USE_[$module]}
		MODULE_URI=""
		for URI in $CALCULATE_URI $MIRROR_URI
		do
			MODULE_URI="${MODULE_URI} ${URI}/${CALCULATE_TARBALL_[$module]}"
		done
		if [[ -n $MODULE_USE ]]
		then
			if use $MODULE_USE
			then
				MODULE_INFO+=("calculate-$module ${CALCULATE_MODULES_[$module]}")
			fi
			MODULE_URI="${MODULE_USE}? ( $MODULE_URI )"
		else
				MODULE_INFO+=("calculate-$module ${CALCULATE_MODULES_[$module]}")
		fi
		SRC_URI="$SRC_URI $MODULE_URI"
	done

	IUSE="minimal pxe ${CALCULATE_MODULES_USE_[@]}"
	S="${WORKDIR}"
}

prepare_variables

RDEPEND="
	!minimal? ( dev-python/py-smbpasswd
		sys-boot/grub
		sys-apps/gptfdisk
		>=sys-apps/util-linux-2.19.1
		sys-fs/dosfstools
		sys-fs/squashfs-tools
		sys-block/parted
		dev-python/sudsds[python_targets_python2_7]
		net-libs/dslib
		>=dev-python/pyopenssl-0.14[python_targets_python2_7]
		dev-libs/openssl
		=dev-python/m2crypto-0.22.3-r9[python_targets_python2_7]
		dev-python/cherrypy[python_targets_python2_7]
		dev-python/pytz[python_targets_python2_7]
	)
	>=dev-python/pyxml-0.8[python_targets_python2_7]
	sys-apps/iproute2[-minimal]
	sys-apps/pciutils
	dev-python/progressbar[python_targets_python2_7]
	sys-fs/lvm2
	sys-fs/mdadm
	dev-python/pyinotify[python_targets_python2_7]
	sys-apps/file[python,python_targets_python2_7]

	app-portage/layman
	>=virtual/udev-197
	!app-misc/livecd-tools
	sys-apps/coreutils[xattr]
	sys-boot/syslinux

	>=app-cdr/cdrtools-3.01_alpha13
	>=sys-boot/grub-2.00-r3
	>=sys-boot/syslinux-5
	sys-fs/squashfs-tools

	pxe? ( sys-apps/calculate-server
		net-ftp/tftp-hpa
		net-misc/dhcp
		net-fs/nfs-utils
	)

	>=dev-python/soaplib-1.0

	desktop? (
		media-gfx/feh
		x11-apps/xmessage
		sys-apps/keyutils
		sys-auth/pam_keystore
		dev-lang/swig
		dev-qt/qtdbus:4
	)

	client? (
		>=dev-python/python-ldap-2.0[ssl,python_targets_python2_7]
		sys-auth/pam_client
		>=sys-auth/pam_ldap-180[ssl]
		>=sys-auth/nss_ldap-239
	)

	qt4? (
		dev-python/dbus-python[python_targets_python2_7]
		|| (
			dev-python/pillow[python_targets_python2_7]
			dev-python/imaging[python_targets_python2_7]
		)
		dev-python/pyside[script,python_targets_python2_7]
	)

	dev-python/pexpect[python_targets_python2_7]

	!sys-apps/calculate-lib:3
	!sys-apps/calculate-i18n:3
	!sys-apps/calculate-client:3
	!sys-apps/calculate-desktop:3
	!sys-apps/calculate-console:3
	!sys-apps/calculate-console-gui:3
	!sys-apps/calculate-update:3
	!sys-apps/calculate-install:3
	!sys-apps/calculate-core:3
"

DEPEND="sys-devel/gettext"

REQUIRED_USE="client? ( desktop )"

# @FUNCTION: calculate-utils_src_compile
# @DESCRIPTION:
# Compile all modules of calculate utils
calculate-utils_src_compile() {
	for MODULE in "${MODULE_INFO[@]}"
	do
		MODULE_DATA=( $MODULE )
		MODULE_PN=${MODULE_DATA[0]}
		MODULE_PV=${MODULE_DATA[1]}
		S="${WORKDIR}/${MODULE_PN}-${MODULE_PV}"
		cd $S
		if [[ $MODULE_PN == "calculate-lib" ]]
		then
			sed -ri "/class VariableClVer/{N;N;N;N;s/value = \".*?\"/value = \"${PV}\"/;}" \
				pym/calculate/lib/variables/__init__.py
		fi
		distutils-r1_src_compile
	done
}

# @FUNCTION: calculate-utils_src_install
# @DESCRIPTION:
# Install all modules of calculate utils
calculate-utils_src_install() {
	for MODULE in "${MODULE_INFO[@]}"
	do
		MODULE_DATA=( $MODULE )
		MODULE_PN=${MODULE_DATA[0]}
		MODULE_PV=${MODULE_DATA[1]}
		S="${WORKDIR}/${MODULE_PN}-${MODULE_PV}"
		cd $S
		distutils-r1_src_install
	done
}

python_install() {
	if [[ $MODULE_PN == "calculate-client" ]]
	then
		PYTHON_INSTALL_PARAMS="--install-scripts=/usr/sbin"
	fi
	distutils-r1_python_install $PYTHON_INSTALL_PARAMS
}

calculate-utils_pkg_preinst() {
	dosym /usr/sbin/cl-core /usr/sbin/cl-core-setup
	dosym /usr/sbin/cl-core /usr/sbin/cl-core-patch
	dosym /usr/sbin/cl-core /usr/sbin/cl-update
	dosym /usr/sbin/cl-core /usr/sbin/cl-update-profile
}

calculate-utils_pkg_postinst() {
	einfo "For autoconfigure calculate-core for adminuser perform:"
	einfo "  cl-core --bootstrap <username>"
	einfo "For run calculate-core perform:"
	einfo "  /etc/init.d/calculate-core start"
	einfo "Add calcualte core to autorun:"
	einfo "  rc-update add calculate-core boot"
}
