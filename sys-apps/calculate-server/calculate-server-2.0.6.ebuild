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

DEPEND="=sys-apps/calculate-lib-2.0.8
        >=net-nds/openldap-2.3
        >=sys-auth/pam_ldap-180[ssl]
        >=sys-auth/nss_ldap-239
        >=net-fs/samba-3.0[acl,cups,kernel_linux,ldap,pam]
        >=net-mail/dovecot-1.0[pop3d,ldap,pam,ssl]
        >=net-im/calculate-ejabberd-2.0.2[ldap,pam,ssl,zlib]
        >=mail-mta/postfix-2.2[ldap,pam,ssl]
        >=net-ftp/proftpd-1.3.1[ldap,ncurses,nls,pam,radius,ssl,tcpd]
        >=mail-filter/procmail-3.22"

pkg_postinst() {
	if [ -d /var/calculate/server-data/mail/imap ] || \
		[ -d /var/calculate/server-data/samba/win/profiles ] || \
		[ -d /var/calculate/server-data/samba/unix/profiles ] || \
		[ -d /var/calculate/server-data/samba/win/netlogon ];
	then
		ewarn "Data found in directories of previous version calculate-server"
	fi
	
	if [ -d /var/calculate/server-data/mail/imap ];
	then
		mv -f /var/calculate/server-data/mail/imap/* \
			/var/calculate/server-data/mail/
		rm -rf /var/calculate/server-data/mail/imap
		ewarn
		ewarn "Data from /var/calculate/server-data/mail/imap"
		ewarn "was moved to /var/calculate/server-data/mail/"
	fi
	
	if [ -d /var/calculate/server-data/samba/win/profiles ];
	then
		if [ -d /var/calculate/server-data/samba/profiles/win ];
		then
			mv -f /var/calculate/server-data/samba/win/profiles/* \
				/var/calculate/server-data/samba/profiles/win/
			rmdir /var/calculate/server-data/samba/win/profiles
		else
			mkdir -p /var/calculate/server-data/samba/profiles
			mv -f /var/calculate/server-data/samba/win/profiles \
				/var/calculate/server-data/samba/profiles/win
		fi
		ewarn
		ewarn "Data from /var/calculate/server-data/samba/win/profiles"
		ewarn "was moved to /var/calculate/server-data/samba/profiles/win"
	fi
	
	if [ -d /var/calculate/server-data/samba/unix/profiles ]; \
	then
		if [ -d /var/calculate/server-data/samba/profiles/unix ];
		then
			mv -f /var/calculate/server-data/samba/unix/profiles/* \
				/var/calculate/server-data/samba/profiles/unix/
			rmdir /var/calculate/server-data/samba/unix/profiles
		else
			mkdir -p /var/calculate/server-data/samba/profiles
			mv -f /var/calculate/server-data/samba/unix/profiles \
				/var/calculate/server-data/samba/profiles/unix
		fi
		rmdir /var/calculate/server-data/samba/unix
		ewarn
		ewarn "Data from /var/calculate/server-data/samba/unix/profiles"
		ewarn "was moved to /var/calculate/server-data/samba/profiles/unix"
	fi
	
	if [ -d /var/calculate/server-data/samba/win/netlogon ];
	then
		if [ -d /var/calculate/server-data/samba/netlogon ];
		then
			mv -f /var/calculate/server-data/samba/win/netlogon/* \
				/var/calculate/server-data/samba/netlogon/
			rmdir /var/calculate/server-data/samba/win/netlogon
		else
			mv -f /var/calculate/server-data/samba/win/netlogon \
				/var/calculate/server-data/samba/netlogon
		fi
		rmdir /var/calculate/server-data/samba/win
		ewarn
		ewarn "Data form /var/calculate/server-data/samba/win/netlogon"
		ewarn "was moved to /var/calculate/server-data/samba/netlogon"
	fi
}
