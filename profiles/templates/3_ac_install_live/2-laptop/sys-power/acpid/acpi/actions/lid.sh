# Calculate chmod=0755 comment=#
#!/bin/sh

if [[ -z "$(/usr/libexec/calculate/cl-variable --value desktop.cl_desktop_online_user)" ]]; then

	# Load configuration variables for acpid
	. /etc/conf.d/acpid

	case "${LID_CLOSE_ACTION}" in
		suspend)
			# Check if AC adapter is offline
			if ! grep -qE '1' /sys/class/power_supply/AC/online; then
				loginctl suspend
			fi
			;;
		hibernate)
			loginctl hibernate
			;;
		suspend-hybrid)
			loginctl hybrid-sleep
			;;
		shutdown)
			halt
			;;
	esac
fi
