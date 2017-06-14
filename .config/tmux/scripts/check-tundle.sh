#!/bin/zsh

[[ -z "${TMUXHOME}" ]] && TMUXHOME="${HOME}/.config/tmux"

if [[ ! -e "${TMUXHOME}/bundles/tundle/tundle" ]]; then
    echo "Downloading tundle."

    git clone --depth=1 https://github.com/chilicuil/tundle "${TMUXHOME}/bundles/tundle"
    sed -i 's/^\(DEFAULT_TMUX_PLUGIN_MANAGER_PATH=\).*/\1${TMUXHOME}\/bundles\//g' ${TMUXHOME}/bundles/tundle/scripts/vars.sh

    if [[ -n "${TMUX}" ]]; then
        source "${TMUXHOME}/bundles/tundle/scripts/install_plugins.sh"
    fi
fi
