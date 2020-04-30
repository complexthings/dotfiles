#!/bin/sh

# Make Sure Ansi is Installed
if ! [ -x "$(command -v ansi)" ]; then
    echo "WARNING: ansi is not installed" >&2
    echo "Installing ansi with: curl -OL git.io/ansi"
    curl -OL git.io/ansi
    echo "Setting ansi permissions: chmod 755 ansi"
    chmod 755 ansi
    echo "Moving ansi: sudo mv ansi /usr/local/bin"
    sudo mv ansi /usr/local/bin
fi

# Make sure Lighthouse is Installed
if ! [-x "$(command -v lighthouse)" ]; then
    ansi --yellow "WARNING: lighthouse is not installed" >&2
    ansi --black "Installing lighthouse with: npm install -g lighthouse"
    npm install -g lighthouse
fi

__CWD=$(PWD)

cat <<EOT >> ~/.zprofile
#BASH VARIABLES
# -----------------------------------------------------------------------

# Location of Repos, Sites, etc.
BA_SITES_DIR=/var/www

# Subdirectory of BA_SITES_DIR where you want to keep your DB backups.
BA_DB_DIR=_DBs

# Magento CLI Tool you wish to use for Magento CLI Commands ("n98-magerun2.phar or "bin/magento")
MAGENTO_CLI_TOOL="bin/magento"

# --------------------------------------------------------------------
# ALIASES
# --------------------------------------------------------------------
source $__CWD/aliases.zsh

# --------------------------------------------------------------------
# FUNCTIONS
# --------------------------------------------------------------------
source $__CWD/functions.zsh
EOT

