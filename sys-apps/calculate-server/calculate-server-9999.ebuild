# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit distutils git

EGIT_REPO_URI="git://git.calculate.ru/dev/calculate2/calculate-server.git"

DESCRIPTION="The program for configuring services Linux"
HOMEPAGE="http://www.calculate-linux.org/Calculate2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND="=sys-apps/calculate-lib-9999
	>=net-nds/openldap-2.3[-minimal]
	>=sys-auth/pam_ldap-180[ssl]
	>=sys-auth/nss_ldap-239
	=net-fs/samba-3.0*[acl,cups,kernel_linux,ldap,pam]
	|| ( <net-mail/dovecot-1.2.0[pop3d,ldap,pam,ssl]
	     >=net-mail/dovecot-1.2.0[ldap,pam,ssl] )
	>=mail-mta/postfix-2.2[ldap,pam,ssl]
	>=net-ftp/proftpd-1.3.1[-acl,ldap,ncurses,nls,pam,radius,ssl,tcpd]
	>=mail-filter/procmail-3.22
	>=net-dns/bind-9.6.1_p1[sdb-ldap]
	>=net-proxy/squid-3.0.14[ldap,pam,ssl]
	>=net-misc/dhcp-3.1.2_p1"

RDEPEND="${DEPEND}"
