# Calculate comment=# path=/etc/bash/bashrc.d
#!/bin/bash

# set cache directory for root user
if [[ ${EUID} == 0 ]] ; then
	export CCACHE_DIR="$((source <(cat /etc/portage/make.conf/*) ;echo $CCACHE_DIR) 2>/dev/null)"
fi
