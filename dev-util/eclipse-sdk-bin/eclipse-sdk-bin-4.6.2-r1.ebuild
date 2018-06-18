# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils versionator java-utils-2

SR="$(get_version_component_range 3-)"
RNAME="neon"

SRC_BASE="http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/${RNAME}/${SR}/eclipse-java-${RNAME}-${SR}-linux-gtk"

DESCRIPTION="Eclipse SDK"
HOMEPAGE="http://www.eclipse.org"
SRC_URI="
	amd64? ( ${SRC_BASE}-x86_64.tar.gz&r=1 -> eclipse-java-${RNAME}-${SR}-linux-gtk-x86_64-${PV}.tar.gz )
	x86? ( ${SRC_BASE}.tar.gz&r=1 -> eclipse-java-${RNAME}-${SR}-linux-gtk-${PV}.tar.gz )
	"

LICENSE="EPL-1.0"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~amd64 ~x86"
IUSE="lombok"

CDEPEND="
	>=dev-java/commons-httpclient-3.1:3
	>=dev-java/icu4j-56.1:56
	>=dev-java/javax-inject-1:0
	>=dev-java/jsr250-1.2:0
	>=dev-java/xml-commons-resolver-1.2:0
	"
DEPEND="${CDEPEND}"
RDEPEND=">=virtual/jdk-1.8
	x11-libs/gtk+:3
	lombok? ( dev-java/lombok-bin )
	${CDEPEND}"

S="${WORKDIR}"/eclipse

HTML_DOCS="readme/"

_unbundle_single() {
	local mode="${1}" destination_jar="${2}" package="${3}" package_jar="${4}"
	local abs_destination_jar="${PWD}/${destination_jar}"
	local backup_dir="${T}"/${destination_jar##*/}.dir

	if [[ "${mode}" = delete ]]; then
		# Backup META-INF/MANIFEST.MF with checksums
		# Then delete .jar file
		mkdir -p "${backup_dir}"/META-INF
		unzip -p "${destination_jar}" META-INF/MANIFEST.MF \
				| sed -e '/^Name:/d' -e '/^SHA1-Digest:/d' -e '/^\s*$/d' \
				> "${backup_dir}"/META-INF/MANIFEST.MF || die
		rm "${destination_jar}" || die
	elif [[ "${mode}" = wire ]]; then
		einfo "Replacing bundled ${destination_jar}..."
		# Create new .jar based on system-wide build
		# In the process, apply META-INF/MANIFEST.MF backup
		java-pkg_jar-from "${package}" "${package_jar}" "${destination_jar}"
		local source_jar="$(readlink -f "${destination_jar}")"
		rm "${destination_jar}" || die

		cp "${source_jar}" "${destination_jar}" || die
		( cd "${backup_dir}" \
				&& [[ -f "${abs_destination_jar}" ]] \
				&& zip "${abs_destination_jar}" META-INF/MANIFEST.MF >/dev/null
		) || die
	fi
}

_unbundle_known() {
	local mode="${1}"

	# https://wiki.gentoo.org/wiki/Eclipse/Building_From_Source
	_unbundle_single "${mode}" plugins/com.ibm.icu_56.1.0.v201601250100.jar icu4j-56 icu4j.jar
	_unbundle_single "${mode}" plugins/javax.annotation_1.2.0.v201602091430.jar jsr250 jsr250.jar
	_unbundle_single "${mode}" plugins/javax.inject_1.0.0.v20091030.jar javax-inject javax-inject.jar
	_unbundle_single "${mode}" plugins/org.apache.commons.httpclient_3.1.0.v201012070820.jar commons-httpclient-3 commons-httpclient.jar
	_unbundle_single "${mode}" plugins/org.apache.xml.resolver_1.2.0.v201005080400.jar xml-commons-resolver xml-commons-resolver.jar
}

src_prepare() {
	_unbundle_known delete

	ewarn 'Binary dependencies left to unbundle:'
	ewarn "$(find -type f -name '*.jar' -not -wholename '*/org.eclipse*' | sort | sed 's,^\./,,')"

	_unbundle_known wire

	cp "${FILESDIR}"/${P}-eclipse-bin "${T}/eclipse-bin-${SLOT}" || die
	cp "${FILESDIR}"/${P}-eclipserc-bin "${T}/eclipserc-bin-${SLOT}" || die
	sed "s,%SLOT%,${SLOT},g" -i "${T}"/eclipse{,rc}-bin-${SLOT} || die

	eapply_user
}

src_install() {
	local dest=/opt/${PN}-${SLOT}

	insinto ${dest}
	doins -r features icon.xpm plugins artifacts.xml p2 eclipse.ini configuration dropins

	exeinto ${dest}
	doexe eclipse

	einstalldocs

	dobin "${T}"/eclipse-bin-${SLOT}
	insinto /etc
	doins "${T}"/eclipserc-bin-${SLOT}
	make_desktop_entry "eclipse-bin-${SLOT}" "Eclipse ${RNAME^}/${PV} (bin)" "${dest}/icon.xpm"
}
