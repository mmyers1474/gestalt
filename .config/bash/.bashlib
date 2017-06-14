#!/bin/bash

#####
# Custom bash built-in commands
#
ps1ctl() {
    case "$1" in
        -s)
            echo "Activating short prompt."
            PS1="\n\[\e[1;34m\][${ENVTHEME}\u@\h\[\e[0;31m\] ${SSH_TTY:-\l} \[\e[0;32m\]\s +${SHLVL} \[\e[0;35m\]] \[\e[0;36m\]\W\n\[\e[0m\]\$ "
        ;;
        -l)
            echo "Activating long prompt."
            PS1="\n\[\e[0;35m\][\h\[\e[0;35m\]@$(hostname -I | awk '{ print $1 }')\[\e[0;35m\]]\[\e[0;35m\][\[\e[1;36m\]${SSH_TTY:-\l} \[\e[1;32m\]$$/$PPID\[\e[0;35m\]:\[\e[1;33m\]\s \[\e[1;36m\]+${SHLVL} \[\e[1;32m\]${STY:-"NOSCREEN"}\[\e[0;35m\]:\[\e[1;33m\]${WINDOW:--}\[\e[0;35m\]] \w\n\[\e[0;35m\][\[\e[1;34m\]\u\[\e[0;35m\]:\[\e[1;36m\]${UID}/${EUID} \[\e[1;34m\]Jobs\[\e[0;35m\]:\[\e[1;36m\]\j/${!:--} \[\e[1;34m\]CMD\[\e[0;35m\]:\[\e[1;36m\]\!/\# \[\e[1;34m\]RET\[\e[0;35m\]:\[\e[1;36m\]$?\[\e[0;35m\]]\[\e[0;00m\] \$ "
        ;;
        *)
            echo "You must select an option -s or -l."
            return
        ;;
    esac
}
echo "ps1ctl built-in command loaded."
ps1ctl -s
