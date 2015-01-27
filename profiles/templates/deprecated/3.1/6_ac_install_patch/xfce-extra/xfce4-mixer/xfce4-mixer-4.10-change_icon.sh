
if [[ ${EBUILD_PHASE} == configure ]]
then
    einfo "Change icon multimedia-volume-control"
    grep -rl multimedia-volume-control | 
        grep -v -e ChangeLog -e NEWS | 
        xargs sed -i 's/multimedia-volume-control/stock_volume/g'
fi
