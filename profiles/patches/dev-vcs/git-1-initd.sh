post_src_install()
{
	# fix init.d/git-daemon for force stop git-daemon
	sed -ri '/\$\{PIDFILE\}$/ {N;s/(\$\{PIDFILE\})(\n\teend \$)\?/\1\n\tres=$?\n\tpkill -f git-daemon.pid\2res/}' /etc/init.d/git-daemon
	return 0;
}
