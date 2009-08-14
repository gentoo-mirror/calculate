# Copyright 2008 Calculate Pack, http://www.calculate-linux.ru
# Distributed under the terms of the GNU General Public License v2

inherit distutils subversion

ESVN_REPO_URI="http://svn.calculate.ru/calculate2/calculate-server/trunk/"

DESCRIPTION="The program for configuring services Linux"
HOMEPAGE="http://www.calculate-linux.ru/Calculate2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="=sys-apps/calculate-lib-9999
        >=net-nds/openldap-2.3[-minimal]
        >=sys-auth/pam_ldap-180[ssl]
        >=sys-auth/nss_ldap-239
        >=net-fs/samba-3.0[acl,cups,kernel_linux,ldap,pam]
        >=net-mail/dovecot-1.0[pop3d,ldap,pam,ssl]
        >=mail-mta/postfix-2.2[ldap,pam,ssl]
        >=net-ftp/proftpd-1.3.1[-acl,ldap,ncurses,nls,pam,radius,ssl,tcpd]
        >=mail-filter/procmail-3.22"
