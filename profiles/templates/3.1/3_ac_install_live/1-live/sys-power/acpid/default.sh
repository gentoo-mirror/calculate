# Calculate comment=# hr_laptop!=
#!/bin/sh
# /etc/acpi/default.sh
# Default acpi script that takes an entry for all actions

set $*

group=${1%%/*}
action=${1#*/}
device=$2
id=$3
value=$4

BACKLIGHT_DIR=/sys/class/backlight/acpi_video0

# increase backlight
inc_backlight() {
	local cur_backlight=$(cat $BACKLIGHT_DIR/actual_brightness)
	local max_backlight=$(cat $BACKLIGHT_DIR/max_brightness)
	[[ $cur_backlight -lt $max_backlight ]] &&
		echo $(($cur_backlight + 1)) >$BACKLIGHT_DIR/brightness
}

# decrease backlight
dec_backlight() {
	local cur_backlight=$(cat $BACKLIGHT_DIR/actual_brightness)
	local max_backlight=$(cat $BACKLIGHT_DIR/max_brightness)
	
	[[ $cur_backlight -gt 0 ]] &&
		echo $(($cur_backlight - 1)) >$BACKLIGHT_DIR/brightness
}

# set powersave cpu mode
powersave_cpu() {
	for cpunum in $(seq 0 $(( $(ls -d /sys/devices/system/cpu/cpu[0-9] | wc -w)-1)));do
		cpufreq-set -c$cpunum -g powersave
	done
}

# set ondemand cpu mode
ondemand_cpu() {
	for cpunum in $(seq 0 $(( $(ls -d /sys/devices/system/cpu/cpu[0-9] | wc -w)-1)));do
		cpufreq-set -c$cpunum -g ondemand
	done
}

# set specified freq for all process
set_freq() {
	for cpunum in $(seq 0 $(( $(ls -d /sys/devices/system/cpu/cpu[0-9] | wc -w)-1)));do
		cpufreq-set -c$cpunum -f$1
	done
}
# increase cpu freq
inc_freq() {
	NEWCPUFREQ=
	for i in `cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies`;do
		if [[ $i == `cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq` ]];then
			if [[ -n $NEWCPUFREQ ]];then
				set_freq $NEWCPUFREQ
			else
				set_freq $i
			fi
			break
		fi
		S=$NEWCPUFREQ
	done
}

# decrease cpu freq
dec_freq() {
	NEWCPUFREQ=
	for i in `cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies`;do
		if [[ -n $NEWCPUFREQ ]];then
				set_freq $i
			break
		fi
		if [[ $i == `cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq` ]];then
			NEWCPUFREQ=$i
		fi
	done
}

log_unhandled() {
	logger "ACPI event unhandled: $*"
}

case "$group" in
	button)
		case "$action" in
#?in(os_install_linux_shortname,CLD,CLDX,CLDG)!=#
			power)
				/sbin/init 0
				;;
#in#
			# if your laptop doesnt turn on/off the display via hardware
			# switch and instead just generates an acpi event, you can force
			# X to turn off the display via dpms.  note you will have to run
			# 'xhost +local:0' so root can access the X DISPLAY.
			#lid)
			#	xset dpms force off
			#	;;

			*)	log_unhandled $* ;;
		esac
		;;

	ac_adapter)
		case "$value" in
			# Add code here to handle when the system is unplugged
			# (maybe change cpu scaling to powersave mode).  For
			# multicore systems, make sure you set powersave mode
			# for each core!
			*0)
				powersave_cpu
				;;

			# Add code here to handle when the system is plugged in
			# (maybe change cpu scaling to performance mode).  For
			# multicore systems, make sure you set performance mode
			# for each core!
			*1)
				ondemand_cpu
				;;

			*)	log_unhandled $* ;;
		esac
		;;
	sony)
		case "$action" in
			hotkey)
				case "$device" in
					SNC)
						case "$id" in
							*01)
								case "$value" in
								*010)
									dec_backlight
									;;
								*011)
									inc_backlight
									;;
								*020)
									dec_freq
									;;
								*021)
									inc_freq
									;;
								*040)
									eject
									;;
								*)	log_unhandled $* ;;
								esac ;;
							*)	log_unhandled $* ;;
						esac
						;;
					*)	log_unhandled $* ;;
				esac
			;;
			*)	log_unhandled $* ;;
		esac
		;;

	*)	log_unhandled $* ;;
esac
