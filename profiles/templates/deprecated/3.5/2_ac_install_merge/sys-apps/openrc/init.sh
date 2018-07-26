# Calculate format=patch mergepkg(sys-apps/openrc)!= path=/lib/rc/sh name=init.sh
<reg>(cp -p "\$RC_LIBEXECDIR"/cache/\* "\$RC_SVCDIR" 2&gt;/dev/null
fi
)(
echo sysinit &gt;"\$RC_SVCDIR"/softlevel
exit)</reg>
<text>\1
rc-update -u
\2</text>
