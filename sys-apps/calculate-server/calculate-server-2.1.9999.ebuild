# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2:2.7"
RESTRICT_PYTHON_ABIS="2.4 2.5 2.6 3.*"

inherit distutils git-2

EGIT_REPO_URI="git://git.calculate.ru/calculate-2.1/calculate-server.git"

DESCRIPTION="The program for configuring services Linux"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND="=sys-apps/calculate-lib-9999
	>=net-nds/openldap-2.3[-minimal]
	>=sys-auth/pam_ldap-180[ssl]
	>=sys-auth/nss_ldap-239
	>=net-fs/samba-3.4.6[acl,client,cups,ldap,netapi,pam,server,smbclient]
	<net-fs/samba-4.0.0
	|| (
			<net-mail/dovecot-1.2.0[pop3d,ldap,pam,ssl]
			>=net-mail/dovecot-1.2.0[ldap,pam,ssl]
	)
	>=mail-mta/postfix-2.2[ldap,pam,ssl]
	>=net-ftp/proftpd-1.3.1[-acl,ldap,ncurses,nls,pam,radius,ssl,tcpd]
	>=mail-filter/procmail-3.22
	>=net-dns/bind-9.6.1_p1[sdb-ldap]
	>=net-proxy/squid-3.0.14[ldap,pam,ssl]
	>=net-misc/dhcp-3.1.2_p1
	>=media-gfx/imagemagick-6.6
	dev-python/pymilter"

RDEPEND="${DEPEND}"
