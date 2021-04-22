# Calculate comment=#
#!/bin/bash

if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

if ${use_color} ; then
	PS_HOSTNAME=$(timeout 0.5 hostname -f 2>/dev/null | sed -r "s/(\.[^.]+)?\.[^.]+$//")
	if [[ -z $PS_HOSTNAME ]]
	then
		PS_HOSTNAME="$(hostname)"
	fi
	if [[ ${EUID} == 0 ]] ; then
		PS1='\[\033[01;31m\]${PS_HOSTNAME}\[\033[01;34m\] \W \$\[\033[00m\] '
	else
		PS1='\[\033[01;32m\]\u@${PS_HOSTNAME}\[\033[01;34m\] \w \$\[\033[00m\] '
	fi
fi
