# Calculate chmod=0755

load_videodrv() {
	info "Loading frame buffer video driver"
	# find all available fb drivers
	videodrv_count=$(find /lib/modules \
		-name "nouveau.ko" -o \
		-name "uvesafb.ko" -o \
		-name "i915.ko" -o \
		-name "radeon.ko" |
		grep -c "")
	# load specified videodrv
	modules_list=
	case "${videodrv}" in
		nouveau)
			modules_list="nouveau"
			;;
		radeon)
			modules_list="radeon"
			;;
		i915|intel)
			modules_list="i915"
			;;
		""|auto)
			# videoautodetect
			if [[ -x /usr/sbin/lspci ]]
			then
				if lspci | grep -m1 VGA | grep -qi intel
				then
					modules_list="i915"
				elif lspci | grep -m1 VGA | grep -qi nvidia
				then
					modules_list="nouveau"
				elif lspci | grep -m1 VGA | grep -q -e "Ati" -e "ATI"
				then
					modules_list="radeon"
				else
					modules_list=""
				fi
			else
				modules_list="i915"
			fi
			;;
	esac
	for x in $modules_list
	do
		if [ "`find /lib/modules -name "${x}.ko" | grep -c ''`" -eq "1" ]
		then
			modprobe "${x}" modeset=1 &>/dev/null
			lsmod | grep -q "^${x}" && \
				[ "`cat /sys/module/${x}/refcnt`" -gt 0 ] && return 0
		fi
	done
	# else load uvesafb with specified video resolution
	if [ -n "${videoresolution}" ]
	then
		if ! echo $videoresolution | grep -q "\-"
		then
			videoresolution="${videoresolution}-32"
		fi
	else
		videoresolution="1024x768-32"
	fi
	modprobe uvesafb mode_option=${videoresolution} &>/dev/null
}
load_videodrv
