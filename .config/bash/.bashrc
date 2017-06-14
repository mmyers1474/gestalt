# .bashrc
# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Source global definitions
if [ -f /etc/bashrc ]; then
    source /etc/bashrc
fi

# Shell Options
#
# Don't wait for job termination notification
# set -o notify
#
# Don't use ^D to exit
# set -o ignoreeof
#
# Use case-insensitive filename globbing
# shopt -s nocaseglob
#
# Make bash append rather than overwrite the history on disk
# shopt -s histappend
#
# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell

# Completion options
# These completion tuning parameters change the default behavior of bash_completion:
#
# Define to access remotely checked-out files over passwordless ssh for CVS
# COMP_CVS_REMOTE=1
#
# Define to avoid stripping description in --option=description of './configure --help'
# COMP_CONFIGURE_HINTS=1
#
# Define to avoid flattening internal contents of tar files
# COMP_TAR_INTERNAL_PATHS=1
#
# Uncomment to turn on programmable completion enhancements.
# Any completions you add in ~/.bash_completion are sourced last.
[[ -f /etc/bash_completion ]] && . /etc/bash_completion

# History Options
#
# Don't put duplicate lines in the history.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
#
# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit'
# export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls' # Ignore the ls command as well
#
# Whenever displaying the prompt, write the previous line to disk
# export PROMPT_COMMAND="history -a"

# Umask
#
# /etc/profile sets 022, removing write perms to group + others.
# Set a more restrictive umask: i.e. no exec perms for others:
# umask 027
# Paranoid: neither group nor others have any perms:
# umask 077
umask 0022

# Functions
#
# Some people use a different file for functions
if [ -f "${BASHDOTDIR}/.bashlib" ]; then
    source "${BASHDOTDIR}/functions.sh"
fi

# Get rid of the shell CTRL-S and CTRL-Q mappings
#tty lnext ^q stop undef start undef
#stty lnext ^q stop undef start undef
stty -ixon

# Aliases
#
# Default to human readable figures
alias df='df -h'                                        #
alias du='du -h'                                        #

# Misc :)                                               #
alias less='less -r'                                    # raw control characters
alias whence='type -a'                                  # where, of a sort
alias grep='grep --color'                               # show differences in colour
alias egrep='egrep --color=auto'                        # show differences in colour
alias fgrep='fgrep --color=auto'                        # show differences in colour

# Some shortcuts for different directory listings       #
alias dir='ls --color=auto --format=vertical'           #
alias vdir='ls --color=auto --format=long'              #
alias l='ls -CF'                                        #
alias ls='ls -hF --color=tty -I ntuser\* -I NTUSER\* -I desktop.ini'        # classify files in colour
alias ll='ls -l'                                        # long list
alias la='ls -A'                                        # all but . and ..
alias lla='ls -lA'                                      #

