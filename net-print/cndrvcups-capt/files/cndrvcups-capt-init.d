#!/sbin/runscript
# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

depend() {
	use cupsd
}

start() {
	ebegin "Starting ccpd"
	start-stop-daemon --start --quiet --exec /usr/sbin/ccpd
	eend $?
}

stop() {
	ebegin "Stopping ccpd"
	start-stop-daemon --stop --quiet --exec /usr/sbin/ccpd
	eend $?
}
