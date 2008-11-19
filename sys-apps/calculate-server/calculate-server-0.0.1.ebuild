# Copyright 2008 Calculate Pack, http://www.calculate-linux.ru
# Distributed under the terms of the GNU General Public License v2

inherit distutils

SRC_URI="ftp://ftp.local.calculate.ru/pub/calculate2/${PN}/${P}.tar.bz2"

DESCRIPTION="The program for configuring services Linux"
HOMEPAGE="http://www.calculate-linux.ru/Calculate_2"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="=sys-apps/calculate-lib-0.0.2
        >=net-nds/openldap-2.3
        >=sys-auth/pam_ldap-180
        >=sys-auth/nss_ldap-239
        >=net-fs/samba-3.0
        >=net-mail/dovecot-1.0
        >=net-im/calculate-ejabberd-2.0.2
		>=mail-mta/postfix-2.2"

pkg_setup() {
	# check: was installed procmail
	if ! eix | grep "\[I\] mail-filter/procmail" >/dev/null;
	then
		einfo "Executing inner emerge, need to updating names of virtaul programms"
		# update env for inner emerge
	    . /etc/make.conf
		# install procmail
	    emerge procmail
	fi
}
