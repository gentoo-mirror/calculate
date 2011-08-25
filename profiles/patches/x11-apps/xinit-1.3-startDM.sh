
# problem detect with sys-apps/openrc-0.8.3-r1
if [[ ${EBUILD_PHASE} == preinst ]]
then
    # when the xinit runs by start-stop-daemon, the console is running start-stop-daemon
    # begins to perceive the bad typing, adding redirect /dev/null to stdin resolve this
    # problem
    # sed adds '</dev/null' to call start-stop-daemon of startDM.sh
    sed -ri 's/(\$\{START_STOP_ARGS\})( \|\|)/\1 <\/dev\/null\2/' ${D}/etc/X11/startDM.sh
fi
