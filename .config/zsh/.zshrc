clear

# Ensure that the work directory exists.
if  [[ ! -d "${ZWORKDIR}" ]]; then
    mkdir -p "${ZWORKDIR}"
fi

# ZSH configuration script autoloader
# sources each file in the ZDOTDIR folder with a .zsh extension
echo "Processing ZSH auto configuration scripts."
for sxp in "${ZDOTDIR}"/*.zsh
do
    echo "Loading: ${sxp}                                 "
    # And source the script
    source "${sxp}"
    tput cuu1
    read -t .7
done
echo "Script autoloading complete.                        "

# Add Tab-completion for SSH host aliases
#complete -o default -o nospace -W "$(/usr/bin/env ruby -ne 'puts $_.split(/[,s]+/)[1..-1].reject{|host| host.match(/*|?/)} if $_.match(/^s*Hosts+/);' < $HOME/.ssh/aliases)" scp sftp ssh

# Reprocess the environment variable definitions since some of the zprezto modules overwrite my values.
source "${HOME}/.zshenv"

declare runner="....................";
echo "FYI:"
echo "PATH:${runner:5} ${PATH}"
echo "CDPATH:${runner:7} ${CDPATH}"

# One off init scripts
source "/home/matthew/.sdkman/bin/sdkman-init.sh"
