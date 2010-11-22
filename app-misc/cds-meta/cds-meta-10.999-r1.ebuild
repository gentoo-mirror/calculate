# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit calculate

DESCRIPTION="Calculate Directory Server (meta package)"
HOMEPAGE="http://www.calculate-linux.org/main/en/cds"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="calculate_nodecoration calculate_nokernel calculate_nonettools
calculate_nonetwork calculate_nowireless
calculate_nodhcp calculate_noftp calculate_nojabber calculate_nomail
calculate_nomysql calculate_nonamed calculate_nopgsql calculate_noproxy
"

RDEPEND="
	!sys-apps/calculate
"

RDEPEND="${RDEPEND}
	app-misc/cl-base-meta
	app-misc/cl-tools-meta

	!calculate_nodecoration? ( app-misc/cl-decoration-meta )
	!calculate_nokernel? ( sys-kernel/calculate-sources )
	!calculate_nonettools? ( app-misc/cl-nettools-meta )
	!calculate_nonetwork? ( app-misc/cl-network-meta )
	!calculate_nowireless? ( app-misc/cl-wireless-meta )

	!calculate_nodhcp? ( net-misc/dhcp )
	!calculate_noftp? (
		net-ftp/ftp
		net-ftp/proftpd
	)
	!calculate_nojabber? ( net-im/calculate-ejabberd )
	!calculate_nomail? (
		mail-filter/clamsmtp
		mail-filter/postgrey
		mail-filter/procmail
		mail-filter/spamassassin
		mail-mta/postfix
		net-mail/dovecot
		net-mail/fetchmail
	)
	!calculate_nomysql? ( dev-db/mysql )
	!calculate_nonamed? ( net-dns/bind )
	!calculate_nopgsql? ( dev-db/postgresql-server )
	!calculate_noproxy? (
		net-proxy/havp
		net-proxy/squid
	)
"

# LDAP
RDEPEND="${RDEPEND}
	net-nds/openldap
"

cxxflags_present_in() {
	grep CXXFLAGS $1 &>/dev/null
	return $?
}

append_cxxflags_to() {
	sed -i '$aCXXFLAGS="\${CFLAGS}"' $1
}


pkg_postinst() {
	cxxflags_present_in /etc/make.conf || append_cxxflags_to /etc/make.conf
	calculate_change_version

	local calculatename=$( get_value calculate < ${CALCULATE_INI} )
	local system=$( get_value system < ${CALCULATE_INI} )

	# check version on stable (PV hasn't 999)
	if ! [[ "$PV" =~ 999 ]]
	then
		[[ "$calculatename" == "CDS" ]] &&
		[[ -n "$(eselect profile show |
			grep calculate/${system}/${calculatename}/${ARCH}/developer)" ]] && 
			eselect profile set calculate/${system}/${calculatename}/${ARCH}
	fi
}
