# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="7"
PYTHON_COMPAT=(python3_9)

inherit distutils-r1 git-r3

EGIT_REPO_URI="git://git.calculate-linux.org/calculate-2.1/calculate-server.git"

DESCRIPTION="Configuration utility for Linux services"
HOMEPAGE="http://www.calculate-linux.org/main/en/calculate2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

IUSE="calculate_nomail
calculate_nodhcp
calculate_noftp
calculate_nojabber
calculate_nonamed
calculate_nosamba
calculate_noproxy"

DEPEND="!sys-apps/calculate-lib
	>=net-nds/openldap-2.3[-minimal]
	>=sys-auth/pam_ldap-180[ssl]
	>=sys-auth/nss_ldap-239
	!<sys-apps/calculate-utils-3.5.0_alpha44
	!calculate_nosamba? (
		|| ( 
			<net-fs/samba-4[acl,client,cups,ldap,netapi,pam,server,smbclient]
			>=net-fs/samba-4[acl,client,cups,ldap,pam]
		)
	)
	!calculate_nomail? ( 
		|| ( <net-mail/dovecot-1.2.0[pop3d,ldap,pam,ssl]
			>=net-mail/dovecot-1.2.0[ldap,pam,ssl(+)]
		)
		>=mail-filter/procmail-3.22
		dev-python/pymilter[python_targets_python3_9]
		>=mail-mta/postfix-2.2[ldap,pam,ssl,sasl,dovecot-sasl]
	)
	!calculate_noftp? (
		|| ( <net-ftp/proftpd-1.3.3[-acl,ldap,ncurses,nls,pam,ssl,tcpd]
			>=net-ftp/proftpd-1.3.3[-acl,ident,ldap,ncurses,nls,pam,ssl,tcpd]
		)
	)
	!calculate_nojabber? (
		|| ( >=net-im/ejabberd-2.1.8[mod_pubsub,ldap]
			>=net-im/ejabberd-16.04-r1[ldap] )
		|| ( media-gfx/imagemagick
			media-gfx/graphicsmagick )
	)
	!calculate_nonamed? ( >=net-dns/bind-9.6.1_p1[sdb-ldap] )
	!calculate_noproxy? ( >=net-proxy/squid-3.0.14[ldap,pam,ssl] )
	!calculate_nodhcp? ( >=net-misc/dhcp-3.1.2_p1 )
	dev-python/python-ldap[ssl,python_targets_python3_9]
	dev-python/lxml[python_targets_python3_9]
"

RDEPEND="${DEPEND}"
