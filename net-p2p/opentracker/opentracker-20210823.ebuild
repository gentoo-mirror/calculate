# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="An open and free bittorrent tracker"
HOMEPAGE="https://erdgeist.org/arts/software/opentracker/"

EGIT_REPO_URI="git://erdgeist.org/opentracker"
EGIT_COMMIT="110868ec4ebe60521d5a4ced63feca6a1cf0aa2a"

LICENSE="BEER-WARE"
SLOT="0"
#KEYWORDS="~amd64 ~x86"
IUSE="+blacklist debug gzip-always ip-from-query ip-from-proxy ipv6 fullscrapes-modest live-sync
	live-sync-unicast log-networks-full log-numwant persistence restrict-stats spot-woodpeckers syslog whitelist"
REQUIRED_USE="^^ ( blacklist whitelist )
	live-sync-unicast? ( live-sync )
	persistence? ( !ipv6 )"

DEPEND="sys-libs/zlib"
RDEPEND="acct-user/opentracker
	dev-libs/libowfat
	${DEPEND}"

PATCHES="${FILESDIR}/${PN}-Makefile.patch ${FILESDIR}/${PN}-conf.patch"

src_prepare() {
	default

	local MYFEATURES="BUILD_FEATURES+=-DWANT_COMPRESSION_GZIP -DWANT_FULLSCRAPE"
	use blacklist && MYFEATURES+=" -DWANT_ACCESSLIST_BLACK"
	use gzip-always && MYFEATURES+=" -DWANT_COMPRESSION_GZIP_ALWAYS"
	use ip-from-query && MYFEATURES+=" -DWANT_IP_FROM_QUERY_STRING"
	use ip-from-proxy && MYFEATURES+=" -DWANT_IP_FROM_PROXY"
	use ipv6 && MYFEATURES+=" -DWANT_V6"
	use fullscrapes-modest && MYFEATURES+=" -DWANT_MODEST_FULLSCRAPES"
	use live-sync && MYFEATURES+=" -DWANT_SYNC_LIVE"
	use live-sync-unicast && MYFEATURES+=" -DSYNC_LIVE_UNICAST"
	use log-networks-full && MYFEATURES+=" -DWANT_FULLLOG_NETWORKS"
	use log-numwant && MYFEATURES+=" -DWANT_LOG_NUMWANT"
	use persistence && MYFEATURES+=" -DWANT_PERSISTENCE"
	use spot-woodpeckers && MYFEATURES+=" -DWANT_SPOT_WOODPECKER"
	use syslog && MYFEATURES+=" -DWANT_SYSLOGS"
	use restrict-stats && MYFEATURES+=" -DWANT_RESTRICT_STATS"
	use whitelist && MYFEATURES+=" -DWANT_ACCESSLIST_WHITE"

	if use debug; then
		MYFEATURES+=" -D_DEBUG_HTTPERROR"
		sed -i -e "/^#CFLAGS_production.*OPTS_debug/s/^#//" Makefile || die "sed DEBUG CFLAGS enable failed in Makefile"
	fi
	sed -i "/^BUILD_FEATURES/s/^.*/${MYFEATURES}/" Makefile || die "sed BUILD_FEATURES failed in Makefile"
}

src_install() {
	dodoc README*
	insinto /etc
	newins opentracker.conf.sample opentracker.conf

	cp "${FILESDIR}"/opentracker.init.d "${T}"/opentracker || die
	doinitd "${T}"/opentracker

	dodir /usr/bin
	emake install DESTDIR="${D}"

	if use debug && ! has nostrip ${FEATURES}; then
		ewarn "
		********************************************************************************
			Please emerge with FEATURES=nostrip to get debug really effective
		********************************************************************************
		"
	fi
}
