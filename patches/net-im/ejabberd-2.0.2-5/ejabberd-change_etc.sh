# changing /etc/init.d and /etc/conf.d

post_src_install() {
	einfo "Changing ejabberd initd and confd"
	newinitd "${BASH_SOURCE/ejabberd-change_etc.sh}/${PN}-2.initd" ${PN} || die
	newconfd "${BASH_SOURCE/ejabberd-change_etc.sh}/${PN}-2.confd" ${PN} || die
}
