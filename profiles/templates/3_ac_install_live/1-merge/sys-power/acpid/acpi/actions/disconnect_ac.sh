#!/bin/bash

# Load configuration variables for acpid
. /etc/conf.d/acpid

# Script to suspend the system when the laptop lid is closed
if [[ ${LID_CLOSE_ACTION} == suspend ]] && grep -qE 'closed' /proc/acpi/button/lid/*/state; then
	loginctl suspend
fi
