# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Calculate Directory Server (meta package)"
HOMEPAGE="http://www.calculate-linux.org/main/en/cds"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="
calculate_nodecoration
calculate_nokernel
calculate_nonettools
calculate_nonetwork
calculate_nodhcp
calculate_noftp
calculate_nojabber
calculate_nomail
calculate_nonamed
calculate_nopgsql
calculate_noproxy
ldap
"

RDEPEND="${RDEPEND}
	app-misc/cl-base-meta
	app-misc/cl-tools-meta

	!calculate_nodecoration? ( app-misc/cl-decoration-meta )
	!calculate_nokernel? ( sys-kernel/calculate-sources )
	!calculate_nonettools? ( app-misc/cl-nettools-meta )
	!calculate_nonetwork? ( app-misc/cl-network-meta )

	!calculate_nodhcp? ( net-misc/dhcp )
	!calculate_noftp? (
		net-ftp/ftp
		net-ftp/proftpd
	)
	!calculate_nojabber? ( net-im/ejabberd )
	ldap? ( net-nds/openldap )
	!calculate_nomail? (
		mail-filter/clamsmtp
		mail-filter/dkim-milter
		mail-filter/postgrey
		mail-filter/procmail
		mail-mta/postfix
		net-mail/dovecot
		net-mail/fetchmail
	)
	!calculate_nonamed? ( net-dns/bind )
	!calculate_nopgsql? (
		dev-db/postgresql-server
		sys-apps/most
	)
	!calculate_noproxy? (
		net-proxy/havp
		net-proxy/squid
		net-proxy/squidguard
	)
"

