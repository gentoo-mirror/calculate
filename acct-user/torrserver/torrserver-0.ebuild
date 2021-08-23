# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-user

DESCRIPTION="User for net-p2p/torrserver-bin"
KEYWORDS="amd64"
ACCT_USER_ID=-1
ACCT_USER_GROUPS=( torrserver )
ACCT_USER_HOME="/var/lib/torrserver/"

acct-user_add_deps
