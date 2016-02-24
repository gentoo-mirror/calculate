# Calculate comment=#
#!/bin/bash

case ${COLORTERM} in
    xfce4-terminal*)
        [[ -z $TMUX ]] && export TERM=xterm-256color
    ;;
esac
