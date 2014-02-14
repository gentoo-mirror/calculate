# Calculate comment=# path=/etc/bash
#!/bin/bash

if ${use_color} ; then
	alias ls='ls --color=yes'
	alias grep='grep --colour=yes'
	alias egrep='egrep --colour=yes'
	alias fgrep='fgrep --colour=yes'
	alias emerge='emerge --color=y'
	alias eix='eix -F'
fi
