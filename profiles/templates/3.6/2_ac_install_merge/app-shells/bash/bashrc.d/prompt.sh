# Calculate comment=#
#!/bin/bash

if ${use_color} ; then
	PS_HOSTNAME=$(hostname -f | sed -r "s/(\.[^.]+)?\.[^.]+$//")
	if [[ ${EUID} == 0 ]] ; then
		PS1='\[\033[01;31m\]${PS_HOSTNAME}\[\033[01;34m\] \W \$\[\033[00m\] '
	else
		PS1='\[\033[01;32m\]\u@${PS_HOSTNAME}\[\033[01;34m\] \w \$\[\033[00m\] '
	fi
fi
