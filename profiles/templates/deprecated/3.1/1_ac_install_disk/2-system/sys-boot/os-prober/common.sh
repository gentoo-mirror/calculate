# Calculate format=patch
<reg>(set \+f)
(\s*)(printf '%s %s)</reg>
<text>\1
\2[[ $(mapdevfs "$1") != #-os_mapper_root_dev-# ]] || [[ $2 != / ]] &amp;&amp;
\2\t\3</text>
