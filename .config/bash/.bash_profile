# .bash_profile
export HISTCONTROL=ignorespace
export HISTFILE=${HOME}/.config/temp/bash_history

export PATH="${HOME}/.config/sbin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin"

 #Get the aliases and functions
if [ -f "${HOME}/.bashrc" ] ; then
    source "${HOME}/.bashrc"
fi

# User specific environment and startup programs

# Set PATH so it includes user's private bin if it exists
if [ -d "${HOME}/bin" ] ; then
    export PATH="${PATH}:${HOME}/bin"
fi

# Set MANPATH so it includes users' private man if it exists
if [ -d "${HOME}/man" ]; then
    export MANPATH="${HOME}/man:${MANPATH}"
fi

#Set INFOPATH so it includes users' private info if it exists
if [ -d "${HOME}/info" ]; then
    export INFOPATH="${HOME}/info:${INFOPATH}"
fi

# Set a CDPATH so we can quickly switch to commonly used locations
export CDPATH="${CDPATH}"

# Set custom directory listing colors.
export LS_COLORS='no=00:fi=00:di=01;34:ln=00;36:pi=40;33:so=00;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;32:*.cmd=00;32:*.exe=00;32:*.com=00;32:*.btm=00;32:*.bat=00;32:*.sh=00;32:*.csh=00;32:*.tar=00;31:*.tgz=00;31:*.arj=00; 31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.bz=00;31:*.tz=00;31:*.rpm=00;31:*.cpio=00;31:*.jpg=00;35:*.gif=00;35:*.bmp=00;35:*.xbm=00;35:*.xpm=00;35:*.png=00;35:*.tif=00;35:'

export GPGKEY="2048R/E66BBF93"
export SVN_EDITOR="vim"

#### Confiugration for virtualenv/virtualenvwrapper
# export WORKON_HOME=$HOME/.virtualenvs
# export PROJECT_HOME=$HOME/Devel
# export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
# source /usr/local/bin/virtualenvwrapper_lazy.sh
export WORKON_HOME=$HOME/Work/.virtualenvs
export PROJECT_HOME=$HOME/Work
export VIRTUALENVWRAPPER_SCRIPT=/usr/bin/virtualenvwrapper.sh

