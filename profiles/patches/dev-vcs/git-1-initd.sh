post_src_install()
{
	# fix init.d/git-daemon for force stop git-daemon
	sed -ri 's/(\$\{PIDFILE\})$/\1\n\tpkill -f git-daemon.pid\n\ttrue/' ${D}/etc/init.d/git-daemon
	return 0;
}
