# Calculate dotall format=patch
<reg>
(\s*)(source /etc/portage/make.conf)( 2&gt;/dev/null)
(\s*
\s*overlay)</reg>
<text>
\1\2\3
\1\2/*\3
\4</text>
