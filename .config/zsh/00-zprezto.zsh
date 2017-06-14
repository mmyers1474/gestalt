# load-zprezto.zsh
#
# This is the Zprezto shell initialization modules.  This is called as a part of Zsh startup
# from the .zshrc configuration file.

# If te zprezto init.zsh script is missing, then wipe out the installation directory and re-clone
# it from Github.
if [[ ! -s "${ZDOTDIR:-$HOME}/zprezto/init.zsh" ]]; then
    clear
    echo -n "The Zsh configuration framework Zprezto appears to be missing or invalid.  Do you wish to (re)install Zprezto? (y/n) "; read -rs -k1 install; echo
    if [[ "${install}" =~ (y|Y) ]]; then
        echo "Please wait while downloading/installing Zprezto..."
        rm -Rf "${ZDOTDIR:-$HOME}/zprezto" > /dev/null 2>&1
        mkdir -p "${ZDOTDIR:-$HOME}/zprezto"
        git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/zprezto"

        # Apply my customizations to a new Zprezto install so I have it my way.
        # Here are the sedits.
        # Use zprezto rather .zprezto for the installation directory
        sed -i "s|\/.zprezto\/|\/zprezto\/|g" "${ZDOTDIR}/zprezto/init.zsh"
        # Relocate the history file in the /temp directory rather than ZDOTDIR.
        sed -i "s|^HISTFILE=.*$|HISTFILE=/temp/.zhistory|g" "${ZDOTDIR}/zprezto/modules/history/init.zsh"
    fi
elif [[ -s "${ZDOTDIR:-$HOME}/zprezto/init.zsh" ]]; then
    tput cuu1
    echo "Initializing Zprezto Zsh configuration framework."
    source "${ZDOTDIR:-$HOME}/zprezto/init.zsh"
fi
