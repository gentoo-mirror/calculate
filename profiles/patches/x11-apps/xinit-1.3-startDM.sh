
if [[ ${EBUILD_PHASE} == preinst ]]
then
    sed -ri 's/(\$\{START_STOP_ARGS\})( \|\|)/\1 <\/dev\/null\2/' ${D}/etc/X11/startDM.sh
fi
