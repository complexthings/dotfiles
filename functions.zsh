# General
source ~/.dotfiles/functions/bash.zsh
source ~/.dotfiles/functions/git.zsh

# Development
source ~/.dotfiles/functions/sites.zsh
source ~/.dotfiles/functions/magento.zsh

# MISC
source ~/.dotfiles/functions/docker.zsh
source ~/.dotfiles/functions/downstream.zsh

get-log-file() {
    local CLOUD_ENVIRONMENT_NUM=$1
    local LOG_PATH=$2
    local NEW_FILE_NAME=$3

    scp $CLOUD_ENVIRONMENT_NUM.$CLOUD_ENVIRONMENT:$LOG_PATH $NEW_FILE_NAME
}