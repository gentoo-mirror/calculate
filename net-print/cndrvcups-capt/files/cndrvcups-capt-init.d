#!/sbin/runscript
#
# ccpd          startup script for Canon Printer Daemon for CUPS
#
#               Modified for Debian GNU/Linux
#               by Raphael Doursenaud <rdoursenaud@free.fr>.
#               Modified for Gentoo GNU/Linux
#               by NStorm, daks
DAEMON=/usr/sbin/ccpd
LOCKFILE=/var/lock/subsys/ccpd
NAME=ccpd
DESC="Canon Printer Daemon for CUPS"
test -f $DAEMON || exit 0

depend() {
  need net
  after cupsd
}

start() {
  ebegin "Starting $DESC: $NAME"
  start-stop-daemon --start --quiet --exec $DAEMON
  eend $?
}

stop() {
  ebegin "Stopping $DESC: $NAME"
  start-stop-daemon --stop --quiet --oknodo --exec $DAEMON
  eend $?
}
