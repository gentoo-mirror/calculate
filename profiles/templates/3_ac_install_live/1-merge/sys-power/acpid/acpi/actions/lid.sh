# Calculate chmod=0755 comment=#
#!/bin/sh

if [[ -z "$(/usr/libexec/calculate/cl-variable --value desktop.cl_desktop_online_user)" ]]
then
	source /etc/conf.d/acpid
	case "${LID_CLOSE_ACTION}" in
		suspend)
#?pkg(sys-auth/elogind)!=#
			loginctl suspend
#!pkg#
			pm-suspend
#pkg#
			;;
		hibernate)
#?pkg(sys-auth/elogind)!=#
			loginctl hibernate
#!pkg#
			pm-hibernate
#pkg#
			;;
		suspend-hybrid)
#?pkg(sys-auth/elogind)!=#
			loginctl hybrid-sleep
#!pkg#
			pm-suspend-hybrid
#pkg#
			;;
		shutdown)
			halt
			;;
	esac
fi
