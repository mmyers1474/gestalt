# -------------------------------------------------------------------
# directory movement
# -------------------------------------------------------------------
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias 'bk=cd $OLDPWD'

# -------------------------------------------------------------------
# directory information
# -------------------------------------------------------------------
# Colorize output, add file type indicator, and put sizes in human readable format

alias ls='ls -GFh --color=auto --group-directories-first'
[[ "${OS}" == "Windows_NT" ]] && alias ls='ls -GFh --color=auto --group-directories-first --ignore=ntuser\* --ignore=NTUSER\* --ignore=putty.rnd'
alias ll='ls -l'                                            # Same as above, but in long listing format
alias lla='ls -lA'                                          # List almost all files.
alias llh='ls -ld .??*'                                     # List only hidden directories and files.
alias lld='ls -lA | egrep ^d'                               # List only directories
alias llf='ls -lA | egrep -v ^d'                            # List only files
# -------------------------------------------------------------------
# Git
# -------------------------------------------------------------------
alias ga='git add'
alias gp='git push'
alias gl='git log'
alias gpl="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gs='git status'
alias gd='git diff'
alias gm='git commit -m'
alias gma='git commit -am'
alias gb='git branch'
alias gc='git checkout'
alias gcb='git checkout -b'
alias gra='git remote add'
alias grr='git remote rm'
alias gpu='git pull'
alias gcl='git clone'
alias gta='git tag -a -m'
alias gf='git reflog'
alias gv='git log --pretty=format:'%s' | cut -d " " -f 1 | sort | uniq -c | sort -nr'

# -------------------------------------------------------------------
# Python virtualenv 
# -------------------------------------------------------------------
alias mkenv='mkvirtualenv'
alias mkprj='mkproject'
alias on="workon"
alias off="deactivate"

# -------------------------------------------------------------------
# Docker
# -------------------------------------------------------------------
alias open-docker="open http://$DOCKER_IP"
alias dc='docker-compose'
alias dcr='docker-compose run'
alias dcu='docker-compose up'
alias dcps='docker-compose ps'
alias dcd='docker-compose down'
 
# -------------------------------------------------------------------
# Tmux
# -------------------------------------------------------------------
alias tsesops='tmux new-session -s "Operations"'
alias tsessup='tmux new-session -s "Extension"'
alias tsplit='tmux split-window'
alias tsplitv='tsplit -v'
alias tsplith='tsplit -h'
alias tcon='tsplit -v -p 80 tmux -C'

if [[ -z ${MSYSTEM} ]] && [[ ${OS} == "Windows_NT" ]]; then
    alias ping='/C/Windows/System32/ping.exe'
fi

#alias ttail='tmux split -d tail -f'
#alias texec='tmux split -d'
#alias trun=texec
#alias tswn='printf "\033k%s\033\\" "$1"'
#alias tspt='printf "\033]2;%s\033\\" "$1"'
