# Calculate chmod=0755 comment=#
#!/bin/sh

if [[ -z "$(/usr/libexec/calculate/cl-variable --value desktop.cl_desktop_online_user)" ]]
then
	source /etc/conf.d/acpid
	case "${LID_CLOSE_ACTION}" in
		suspend)
			pm-suspend
			;;
		hibernate)
			pm-hibernate
			;;
		suspend-hybrid)
			pm-suspend-hybrid
			;;
		shutdown)
			halt
			;;
	esac
fi
