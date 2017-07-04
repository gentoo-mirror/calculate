#!/sbin/openrc-run
# Copyright 1999-2017 Gentoo Foundation

description="Bittorrent tracker"
command="/usr/bin/opentracker"
command_args="-f /etc/opentracker.conf"
pidfile="/var/run/opentracker.pid"
start_stop_daemon_args="-w 1 -b -m --pidfile ${pidfile}"

depend() {
	use net
}

