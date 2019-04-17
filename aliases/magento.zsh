# MAGENTO 2
# ---------------------------------------

# Alias for N98 Magerun2
alias n98="n98-magerun2.phar"

# Alias to run Magento CLI Tool
if [[ $MAGENTO_CLI_TOOL == "n98" ]]; then
    alias bmage="n98"
else
    alias bmage="php bin/magento"
fi

# Alias for Magento2 Setup Static Content Deploy
alias bmage-up="bmage setup:upgrade"

# Alais to run Magento Cloud CLI Tool
alias magec="magento-cloud"

# Alias to run m2clearcache
alias bmage-cache="m2clearcache"

# Alias to run m2-start-development
alias bmage-dev="m2-start-development"

# Alias to run m2-fixes
alias bmage-fix="m2-fixes"

# Alias to run m2-local-setup
alias bmage-local="m2-setup-local"

# Alias to run m2getclouddb
alias magec-db="m2getcloudcb"

# Alias to run m2getcloudmedia
alias magec-media="m2getcloudmedia"

# Alias to run m2cloudssh
alias magec-ssh="m2cloudssh"