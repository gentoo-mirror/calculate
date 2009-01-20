# Copyright 2008 Calculate Pack, http://www.calculate-linux.ru
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

inherit distutils

SRC_URI="ftp://ftp.local.calculate.ru/pub/calculate2/${PN}/${P}.tar.bz2"

DESCRIPTION="The program for configuring services Linux"
HOMEPAGE="http://www.calculate-linux.ru/Calculate_2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="=sys-apps/calculate-lib-2.0.6
        >=net-nds/openldap-2.3
        >=sys-auth/pam_ldap-180[ssl]
        >=sys-auth/nss_ldap-239
        >=net-fs/samba-3.0[acl,cups,kernel_linux,ldap,pam]
        >=net-mail/dovecot-1.0[ldap,pam,ssl]
        >=net-im/calculate-ejabberd-2.0.2[ldap,pam,ssl,zlib]
        >=mail-mta/postfix-2.2[ldap,pam,ssl]
        >=net-ftp/proftpd-1.3.1[ldap,ncurses,nls,pam,radius,ssl,tcpd]
        >=mail-filter/procmail-3.22"
