# MAGENTO 2
# ---------------------------------------

#####################################################################
#   Magento 2 Hard Cache Clean that empties: cache, full page cache,
#   generated php file, deployed static content, requirejs files, 
#   knockoutjs & phtml view_preprocessed files.  Also flushes redis 
#   cache.
#
#   Usage:
#   m2clearcache $1
#   Arguments:
#       $1  (optional) Theme you wish to clear static content for.
#####################################################################
m2clearcache() {
    local pubPath=pub/static/frontend/BlueAcorn
    local staticMessage="Static Content Cleaned ✅"

    __echo_blue "Magento 2 Hard Cache Clean"

    rm -rf \
        var/cache \
        var/page_cache
    
    __echo_green "Caches Cleaned ✅"

    rm -rf \
        var/generation \
        generated/code \
        generated/metadata \
        var/view_preprocessed
    
    __echo_green "Generated Code Cleaned ✅"

    if [[ -n $1 ]]; then
        pubPath=$pubPath/$1
        staticMessage="Static Content Cleaned for $1 ✅"
    fi

    rm -rf \
        pub/static/deployed_version.txt \
        $pubPath

    if [[ -n $2 ]]; then
        rm -rf pub/static/frontend/$2 
    fi

    ansi --green $staticMessage

    redis-cli flushall

    __echo_green "Redis Cache Flushed"

    __echo_blue "Magento 2 Hard Cache Complete 💫"
}

#####################################################################
#   Magento 2 Deploy Static Content Shortcut, deploys all areas and
#   themes unless theme is passed.
#
#   Usage:
#   bmage-deploy $1
#
#   Arguments:
#       $1  (optional) Theme Package/name, eg. BlueAcorn/site
#####################################################################
bmage-deploy() {
    local THEME_COMMAND=""
    local MESSAGE="Deploying Static Content"

    if [[ -n $1 ]]; then
        THEME_COMMAND="--theme='$1'"
        MESSAGE="Deploying Static Content for $1"
    fi

    __echo_blue $MESSAGE
    bmage setup:static-content:deploy --jobs=5000 --force $THEME_COMMAND
}

#####################################################################
#   Magento Cloud DB Download helper, takes CLIENT_CODE for 
#   organization purposes and downloads a DB from a cloud environment
#   into your $BA_SITES_DIR/$BA_DB_DIR/CLIENT_CODE
#
#   Usage:
#   m2getclouddb $1 $2
#   Arguments:
#       $1  Client Code you wish to assign for the DB &
#           DB Destination Folder
#       $2  (options) Magento Cloud Environment code you wish to pull
#           the DB from, defaults to staging.
#####################################################################
m2getclouddb() {
    local CLIENT_CODE=$1
    local DUMP_DESTINATION=$BA_SITES_DIR/$BA_DB_DIR/$CLIENT_CODE
    local MAGENTO_CLOUD_ENVIRONMENT=staging

    if [[ -n $2 ]]; then
        MAGENTO_CLOUD_ENVIRONMENT=$2
    fi
    
    if [[ ! -d $DUMP_DESTINATION ]]; then
        if [[ ! -d $BA_SITES_DIR/$BA_DB_DIR ]]; then
            mkdir $BA_SITES_DIR/$BA_DB_DIR
        fi
        mkdir $DUMP_DESTINATION
    fi

    __echo_blue "Getting DB from Magneto Cloud Environment: $MAGENTO_CLOUD_ENVIRONMENT"

    magec db:dump -f $CLIENT_CODE.sql.gz -d $DUMP_DESTINATION -z -e $MAGENTO_CLOUD_ENVIRONMENT
}

#####################################################################
#   Magento Cloud Media Download helper, takes environment name
#   (optional, defualts to staging)  and downloads media from 
#   pub/media directory into  local environment pub/media directory 
#   via rsync.
#
#   Usage:
#   m2getcloudmedia $1
#   Arguments:
#       $1  (options) Magento Cloud Environment code you wish to pull
#           the Media from, defaults to staging.
#####################################################################
m2getcloudmedia() {
    local MAGENTO_CLOUD_ENVIRONMENT=staging

    if [[ -n $1 ]]; then
        MAGENTO_CLOUD_ENVIRONMENT=$1
    fi

    __echo_blue "Getting Media from Magento Cloud Environment: $MAGENTO_CLOUD_ENVIRONMENT"

    magec mount:download --exclude="catalog/product/cache" -m pub/media --target="pub/media" -e $MAGENTO_CLOUD_ENVIRONMENT
}

#####################################################################
#   Magento Cloud Media Download helper, takes environment name
#   (optional, defualts to staging)  and downloads media from 
#   pub/media directory into  local environment pub/media directory 
#   via rsync.
#
#   Usage:
#   m2getcloudmedia $1
#   Arguments:
#       $1  (options) Magento Cloud Environment code you wish to pull
#           the Media from, defaults to staging.
#####################################################################
m2cloudssh() {
    local MAGENTO_CLOUD_ENVIRONMENT=staging

    if [[ -n $1 ]]; then
        MAGENTO_CLOUD_ENVIRONMENT=$1
    fi

    __echo_blue "SSHing into Cloud Environment: $MAGENTO_CLOUD_ENVIRONMENT"
    magec environment:ssh -e $MAGENTO_CLOUD_ENVIRONMENT
}

m2-start-development() {
    local FRONTEND_BUILD_TOOL=grunt

    if [[ -n $1 ]]; then
        FRONTEND_BUILD_TOOL=$1
    fi 

    m2clearcache

    __echo_green "Updating Node Packages"
    npm update

    __echo_green "Updating Composer Packages"
    composer update

    __echo_green "Running Setup:Upgrade"
    bmage-up

    __echo_green "Deploying Static Content"
    bmage-deploy

    __echo_green "Running Front-end Build Tools"
    $FRONTEND_BUILD_TOOL
}

m2-fixes() {
    bmage config:set web/seo/use_rewrites 1
}

m2-setup-local() {
    local SET_TO_ZERO=( 
        dev/css/minify_files 
        dev/css/merge_css_files 
        dev/js/minify_files 
        dev/js/merge_files 
        dev/js/enable_js_bundling 
        dev/static/sign 
        carriers/freeshipping/free_shipping_subtotal
    )

    local SET_TO_ONE=(
        carriers/freeshipping/active
        payment/checkmo/active
        web/seo/use_rewrites
    )

    for config in "${SET_TO_ZERO[@]}"
    do
        __echo_green "Setting $config to 0"
        bmage config:set $config 0
    done

    for config in "${SET_TO_ONE[@]}"
    do
        __echo_green "Setting $config to 1"
        bmage config:set $config 1
    done

    __echo_green "Setting admin/security/session_lifetime to 100000"
    bmage config:set admin/security/session_lifetime 100000
    
    __echo_green "Setting web/cookie/cookie_domain to ''"
    bmage config:set web/cookie/cookie_domain ''

    __echo_red "Please Manually Change your URLS in core_config_data."
    __echo_red "When you have finished, press RETURN"

    read -n 1

    ansi

    __echo_green "Cleaning Cache"

    bmage-cache 
    
    ansi
    
    __echo_green "Running Setup:Upgrade"

    bmage-up 
    
    ansi

    __echo_green "Reindexing"

    bmage indexer:reindex
}

m2-cloud-setup-local() {
    local CLIENT_CODE=$1
    local MAGENTO_CLOUD_ENVIRONMENT=staging
    local DUMP_DESTINATION=$BA_SITES_DIR/$BA_DB_DIR/$CLIENT_CODE
    local DB_NAME=$CLIENT_CODE_db

    if [[ -n $2 ]]; then
        MAGENTO_CLOUD_ENVIRONMENT=$2
    fi

    __echo_green "Importing DB $DUMP_DESTINATION/$CLIENT_CODE.sql.gz"

    m2getclouddb $1 $2
    valet db import $DUMP_DESTINATION/$CLIENT_CODE.sql.gz $DB_NAME
    
    m2getcloudmedia $MAGENTO_CLOUD_ENVIRONMENT

    __echo_red "Please update your app/etc/env.php to point to the DB $DB_NAME"
    __echo_red "When you have finished, press RETURN"

    code app/etc/env.php

    read -n 1
    
    m2-local-setup
}