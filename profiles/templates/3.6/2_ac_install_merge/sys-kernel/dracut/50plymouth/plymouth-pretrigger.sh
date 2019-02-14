# Calculate format=patch
<reg>\n(\s+)(plymouthd)(\s*--attach-to-session)(\s*--pid-file\s*\S+)</reg>
<text>
\1if getargbool 0 quiet
\1then
\1\1\2\4\3
\1else
\1\1\2\4
\1fi
</text>
