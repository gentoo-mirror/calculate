# Copyright 2020-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for net-p2p/torrserver-bin"
ACCT_USER_ID=-1
ACCT_USER_GROUPS=( torrserver )
ACCT_USER_HOME="/var/lib/torrserver"

acct-user_add_deps
