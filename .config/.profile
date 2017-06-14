if [[ "${SHELL}"=="bash" ]] && [[ ~/.bashenv ]]; then
    source ~/.bashenv
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/matthew/.sdkman"
[[ -s "/home/matthew/.sdkman/bin/sdkman-init.sh" ]] && source "/home/matthew/.sdkman/bin/sdkman-init.sh"
