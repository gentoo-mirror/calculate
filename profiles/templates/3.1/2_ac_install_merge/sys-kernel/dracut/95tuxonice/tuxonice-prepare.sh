#!/bin/sh
# prepare parameters for ToI

. /lib/dracut-lib.sh
info "TuxOnIce premodule started"

# first check if ToI support is available
if [ ! -d /sys/power/tuxonice ]; then
  info "Kernel has no tuxonice support, aborting"
  return 0
else
  info "Kernel has tuxonice support, continuing"
fi

if getarg noresume2; then
  warn "noresume2 was specified, aborting"
  return 0
fi

# prepare UserUI
info "Setting up UserUI"
UI="/sbin/tuxoniceui"
UIOPTS=""

if [ -e "/sys/class/graphics/fb0/state" -a -e "/etc/splash/tuxonice/" ]; then
  UIOPTS="$UIOPTS -f"
fi

SYSFS_TUI_UI=/sys/power/tuxonice/user_interface
PROGRAM_PATH=${SYSFS_TUI_UI}/program
ENABLED_PATH=${SYSFS_TUI_UI}/enabled
if [ -e "$UI" ] && [ -e "$PROGRAM_PATH" ] && [ -e "$ENABLED_PATH" ]; then
  info "Using $UI with $UIOPTS"
  echo "$UI $UIOPTS" >$PROGRAM_PATH
  echo 1 >$ENABLED_PATH
else
  warn "$UI is not available"
  if [ -e "$ENABLED_PATH" ]; then
    echo 0 >$ENABLED_PATH
  fi
fi

# install udev rule for resume parameter
if resume=$(getarg resume=) && ! getarg noresume2; then
  resume="${resume#file:}"
  resume="${resume#swap:}"
  resume="${resume%:*}"
else
  unset resume
fi

info "Installing udev rule for resume parameter"
case "$resume" in
  LABEL=*) \
    resume="$(echo $resume | sed 's,/,\\x2f,g')"
    {
    echo "SUBSYSTEM==\"block\", ACTION==\"add|change\", ENV{ID_FS_LABEL}==\"${resume#LABEL=}\", " \
         " RUN+=\"/sbin/tuxonice-resumecheck.sh '/dev/%k' 'resume'\"";
    } >> /etc/udev/rules.d/99-tuxonice.rules
    ;;
  UUID=*) \
    {
    echo "SUBSYSTEM==\"block\", ACTION==\"add|change\", ENV{ID_FS_UUID}==\"${resume#UUID=}\", " \
         " RUN+=\"/sbin/tuxonice-resumecheck.sh '/dev/%k' 'resume'\"";
    } >> /etc/udev/rules.d/99-tuxonice.rules
    ;;
  PARTUUID=*) \
    {
    echo "SUBSYSTEM==\"block\", ACTION==\"add|change\", ENV{ID_PART_ENTRY_UUID}==\"${resume#PARTUUID=}\", " \
         " RUN+=\"/sbin/tuxonice-resumecheck.sh '/dev/%k' 'resume'\"";
    } >> /etc/udev/rules.d/99-tuxonice.rules
    ;;
  *) \
    {
    echo "SUBSYSTEM==\"block\", ACTION==\"add|change\", SYMLINK==\"${resume#/dev/}\", " \
         " RUN+=\"/sbin/tuxonice-resumecheck.sh '/dev/%k' 'resume'\"";
    } >> /etc/udev/rules.d/99-tuxonice.rules
    {
    echo "SUBSYSTEM==\"block\", ACTION==\"add|change\", KERNEL==\"${resume#/dev/}\", " \
         " RUN+=\"/sbin/tuxonice-resumecheck.sh '/dev/%k' 'resume'\"";
    } >> /etc/udev/rules.d/99-tuxonice.rules
    ;;
esac


# install udev rule for resuming
info "Installing udev rule for ToI resume"
{
echo "SUBSYSTEM==\"block\", ACTION==\"add|change\", ENV{ID_FS_TYPE}==\"suspend|swsuspend|swsupend\", " \
     " RUN+=\"/sbin/tuxonice-resumecheck.sh '/dev/%k' 'suspend'\"";
} >> /etc/udev/rules.d/99-tuxonice.rules

# install udev rule to add swapdevice as hibernation target
info "Installing udev rule for ToI swap detection"
{
echo "SUBSYSTEM==\"block\", ACTION==\"add|change\", ENV{ID_FS_TYPE}==\"swap\", " \
     " RUN+=\"/sbin/tuxonice-resumecheck.sh '/dev/%k' 'swap'\"";
} >> /etc/udev/rules.d/99-tuxonice.rules

