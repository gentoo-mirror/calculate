# Calculate chmod=0755
#!/bin/sh
# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
# ex: ts=8 sw=4 sts=4 et filetype=sh

[ -z "$calculate" ] && calculate=$(getarg calculate=)
[ -z "$video" ] && video=$(getarg video=)

[ -z "$calculate" ] && [ -z "$video" ] && return

if [ -n "$video" ]
then
    for i in ${video//,/ }
    do
        if [ -z "${i//[0-9-x@]}" ]
        then
            videoresolution=${i}
        fi
    done
fi

if [[ "${calculate//:/}" != "${calculate}" ]]
then
    for i in ${calculate//,/ }
    do
        case "${i}" in
            video:*)
                videodrv=`echo "${i}" | cut -s -d: -f2-`
                ;;
            resolution:*)
                resolution=`echo "${i}" | cut -s -d: -f2-`
                if [ -n "${resolution}" -a "${resolution}" != "auto" ]
                then
                  videoresolution=${resolution}-32
                fi
                ;;
        esac
    done
fi
