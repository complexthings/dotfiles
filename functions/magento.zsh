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
    __echo_black "rm -rf var/cache var/page_cache"

    rm -rf \
        var/cache \
        var/page_cache

    __echo_green "Caches Cleaned ✅"
    __echo_black "rm -rf var/generation generated/code generated/metadata var/view_preprocessed"

    rm -rf \
        var/generation \
        generated/code \
        generated/metadata \
        var/view_preprocessed

    __echo_green "Generated Code Cleaned ✅"

    if [[ -n $1 ]]; then
        pubPath=$pubPath/$1
        staticMessage="Static Content Cleaned for $1 ✅"
        __echo_black "rm -rf $pubPath pub/static/deployed_version.txt"
    fi

    rm -rf \
        pub/static/deployed_version.txt \
        $pubPath

    if [[ -n $2 ]]; then
        __echo_black "rm -rf pub/static/frontend/$2"
        rm -rf pub/static/frontend/$2
    fi

    ansi --green $staticMessage
    __echo_black "redis-cli flushall"

    warden env exec -T redis redis-cli flushall

    __echo_green "Redis Cache Flushed"

    __echo_blue "Magento 2 Hard Cache Complete 💫"
}

nuke-it() {
    local pubPath=pub/static
    local themePath=frontend/BlueAcorn/site
    if [[ -n $1 ]]; then
        themePath=$1
    fi
    warden env exec php-fpm bash -c "rm -rf var/cache var/page_cache"
    warden env exec php-fpm bash -c "rm -rf var/generation generated/code generated/metadata var/view_preprocessed"
    warden env exec php-fpm bash -c "rm -rf pub/static/deployed_version.txt $pubPath/$themePath"
    warden env exec php-fpm bash -c "bin/magento cache:flush"
    warden env exec -T redis redis-cli flushall
    warden env exec varnish bash -c 'varnishadm "ban req.url ~ /"'
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
    __echo_black "php -d memory_limit=-1 bin/magento setup:static-content:deploy --jobs=5000 --force $THEME_COMMAND"

    warterm -d n98-magerun setup:static-content:deploy --jobs=5000 --force $THEME_COMMAND
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
            __echo_black "mkdir $BA_SITES_DIR/$BA_DB_DIR"
            mkdir $BA_SITES_DIR/$BA_DB_DIR
        fi

        __echo_black "mkdir $DUMP_DESTINATION"
        mkdir $DUMP_DESTINATION
    fi

    __echo_blue "Getting DB from Magneto Cloud Environment: $MAGENTO_CLOUD_ENVIRONMENT"

    __echo_black "magec db:dump -f $CLIENT_CODE.sql.gz -d $DUMP_DESTINATION -z -e $MAGENTO_CLOUD_ENVIRONMENT"
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
    __echo_black "magec mount:download --exclude="catalog/product/cache" --exclude="*.pdf" --exclude="*.tgz" --exclude="*.tar" --exclude="*.gz" --exclude="*.tif" --exclude=".thumbswysiwyg" --exclude="*.csv" -m pub/media --target="pub/media" -e $MAGENTO_CLOUD_ENVIRONMENT"
    magec mount:download --exclude="catalog/product/cache" --exclude="*.pdf" --exclude="*.tgz" --exclude="*.tar" --exclude="*.gz" --exclude="*.tif" --exclude=".thumbswysiwyg" --exclude="*.csv" -m pub/media --target="pub/media" -e $MAGENTO_CLOUD_ENVIRONMENT
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
    __echo_black "magec environment:ssh -e $MAGENTO_CLOUD_ENVIRONMENT"
    magec environment:ssh -e $MAGENTO_CLOUD_ENVIRONMENT
}

#####################################################################
#   Kick off Magento development on your local, clear caches
#   installs node packages, composer pacakges, runs setup:upgrade,
#   deploys static content, just incase (mostly for admin) and runs
#   front-end build tools
#
#   Usage:
#   m2-start-development $1
#   Arguments:
#       $1  Accepts an alternate command to run at the end instead
#           of build tools.
#####################################################################

m2-start-development() {
    local FRONTEND_BUILD_TOOL=gulp

    if [[ -n $1 ]]; then
        FRONTEND_BUILD_TOOL=$1
    fi

    __echo_black "m2clearcache"
    m2clearcache

    __echo_green "Updating Node Packages"
    __echo_black "npm install"
    npm install

    __echo_green "Updating Composer Packages"
    __echo_black "composer install"
    warterm composer install

    __echo_green "Running Setup:Upgrade"
    __echo_black "bmage-up"
    war-up

    __echo_green "Deploying Static Content"
    __echo_black "bmage-deploy"
    bmage-deploy

    __echo_green "Running Front-end Build Tools"
    __echo_black "$FRONTEND_BUILD_TOOL"
    $FRONTEND_BUILD_TOOL
}

#####################################################################
#   General Magento permissions fixes.
#
#   Usage:
#   m2-fix-permissions
#####################################################################

m2-fix-permissions() {
    __echo_green "Running Permissions Fixes"
    __echo_black "find var generated vendor pub/static pub/media app/etc -type f -exec chmod g+w {} +"
    warterm find var generated vendor pub/static pub/media app/etc -type f -exec chmod g+w {} +

    __echo_black "find var generated vendor pub/static pub/media app/etc -type f -exec chmod g+w {} +"
    warterm find var generated vendor pub/static pub/media app/etc -type d -exec chmod g+ws {} +

    __echo_black "chmod u+x bin/magento"
    warterm chmod u+x bin/magento
}

#####################################################################
#   General Magento fixed, really just fixes SEO rewrites and
#   runs the permissions fixes.
#
#   Usage:
#   m2-fixes
#####################################################################

m2-fixes() {
    __echo_green "Running General Fixes"
    __echo_black "bmage config:set web/seo/use_rewrites 1"
    warterm n98-magerun config:set web/seo/use_rewrites 1

    __echo_black "m2-fix-permissions"
    m2-fix-permissions
}

#####################################################################
#   Sets up Magento for local setting a ton of config values you
#   would use on local if you want to know more read the function
#
#   Usage:
#   m2-setup-local-config
#####################################################################

m2-setup-local-config() {
    local SET_TO_ZERO=(
        dev/css/minify_files
        dev/css/merge_css_files
        dev/js/minify_files
        dev/js/merge_files
        dev/js/enable_js_bundling
        dev/static/sign
        carriers/freeshipping/free_shipping_subtotal
        admin/security/use_form_key
    )

    local SET_TO_ONE=(
        carriers/freeshipping/active
        payment/checkmo/active
        web/seo/use_rewrites
        system/full_page_cache/caching_application
    )

    for config in "${SET_TO_ZERO[@]}"
    do
        __echo_green "Setting $config to 0"
        __echo_black "warterm php n98-magerun config:set $config 0 --lock-env"
        warterm php n98-magerun config:set $config 0 --lock-env
    done

    for config in "${SET_TO_ONE[@]}"
    do
        __echo_green "Setting $config to 1"
        __echo_black "warterm php n98-magerun config:set $config 1 --lock-env"
        warterm php n98-magerun $config 1 --lock-env
    done

    warterm php n98-magerun config:set admin/security/session_lifetime 518400 --lock-env
    __echo_black "warterm php n98-magerun config:set admin/security/session_lifetime 518400 --lock-env"
    warterm php n98-magerun config:set web/cookie/cookie_lifetime 14400 --lock-env
    __echo_black "warterm php n98-magerun config:set web/cookie/cookie_lifetime 14400 --lock-env"
}

#####################################################################
#   Locks a couple of config settings common to local dev to your
#   env so when you run app:config:import or setup:upgrade they
#   get processed.
#
#   Usage:
#   m2-setup-local-config-locks
#####################################################################

m2-setup-local-config-locks() {
    local SET_TO_ZERO=(
        dev/css/minify_files
        dev/js/minify_files
        dev/js/merge_files
        dev/static/sign
    )

    for config in "${SET_TO_ZERO[@]}"
    do
        __echo_green "Setting $config to 0"
        __echo_black "bmage config:set $config 0 --lock-env"
        bmage config:set $config 0 --lock-env
    done
}

#####################################################################
#   Runs a ton of commands related to setting up your local env
#
#   Usage:
#   m2-setup-local
#####################################################################

m2-setup-local() {
    __echo_green "Installing Composer Packages"

    __echo_black "composer install"
    composer install

    __echo_green "Running Setup:Upgrade"

    __echo_black "bmage-up"
    bmage-up

    ansi

    __echo_black "m2-setup-local-config"
    m2-setup-local-config

    __echo_green "Setting admin/security/session_lifetime to 100000"
    __echo_black "bmage config:set admin/security/session_lifetime 1000000 --lock-env"
    bmage config:set admin/security/session_lifetime 1000000 --lock-env

    __echo_green "Setting web/cookie/cookie_domain to ''"
    __echo_black "bmage config:set web/cookie/cookie_domain '' --lock-env"
    bmage config:set web/cookie/cookie_domain '' --lock-env

    __echo_red "Please Manually Change your URLS in core_config_data."
    __echo_red "When you have finished, press RETURN"

    read -n 1

    ansi

    __echo_green "Cleaning Cache"

    __echo_black "bmage-cache"
    bmage-cache

    ansi

    __echo_green "Reindexing"

    __echo_black "bmage indexer:reindex"
    bmage indexer:reindex
}

#####################################################################
#   Runs a ton of commands related to setting up your local env
#   when you're on a Magento Cloud site, gets DB, sync media, etc.
#
#   Usage:
#   m2-cloud-setup-local $1 $2
#   Arguments:
#       $1  Client Code, used for naming DB mostly
#       $2  (optional) Magento Cloud Environment you wish to source
#####################################################################

m2-cloud-setup-local() {
    local CLIENT_CODE=$1
    local MAGENTO_CLOUD_ENVIRONMENT=staging
    local DUMP_DESTINATION=$BA_SITES_DIR/$BA_DB_DIR/$CLIENT_CODE
    local DB_NAME=$CLIENT_CODE_db

    if [[ -n $2 ]]; then
        MAGENTO_CLOUD_ENVIRONMENT=$2
    fi

    __echo_green "Importing DB $DUMP_DESTINATION/$CLIENT_CODE.sql.gz"

    __echo_black "m2getclouddb $1 $2"
    m2getclouddb $1 $2

    __echo_black "valet db import $DUMP_DESTINATION/$CLIENT_CODE.sql.gz $DB_NAME"
    valet db import $DUMP_DESTINATION/$CLIENT_CODE.sql.gz $DB_NAME

    __echo_black "m2getcloudmedia $MAGENTO_CLOUD_ENVIRONMENT"
    m2getcloudmedia $MAGENTO_CLOUD_ENVIRONMENT

    __echo_red "Please update your app/etc/env.php to point to the DB $DB_NAME"
    __echo_red "When you have finished, press RETURN"

    __echo_black "code app/etc/env.php"
    code app/etc/env.php

    read -n 1

    __echo_black "m2-setup-local"
    m2-setup-local
}

#####################################################################
#   Simple find and replace for updating a URL
#
#   Usage:
#   m2-update-url $1 $2 $3
#   Arguments:
#       $1  DB Name
#       $2  URL you want to replace (or part of it)
#       $3  URL you want as a replacement, eg. your local url
#####################################################################

m2-update-url() {
    local DB_NAME=$1
    local ORIGINAL_URL=$2
    local NEW_URL=$3

    __echo_black "mysql -ugreg -pgreg -D $DB_NAME -e \"update core_config_data set value = replace(value, '$ORIGINAL_URL', '$NEW_URL') where path like '%url%';\""
    mysql -ugreg -pgreg -D $DB_NAME -e "update core_config_data set value = replace(value, '$ORIGINAL_URL', '$NEW_URL') where path like '%url%';"
}

#####################################################################
#   Simple sanitization of your DB
#
#   Usage:
#   m2-sanitize $1
#   Arguments:
#       $1  DB Name
#####################################################################

m2-sanitize() {
    local DB_NAME=$1
    local ASSET_FILE=~/.dotfiles/assets/m2-sanitize.sql

    __echo_black "mysql -ugreg -pgreg $DB_NAME < $ASSET_FILE"
    mysql -ugreg -pgreg $DB_NAME < $ASSET_FILE
}

#####################################################################
#   Runs lighthouse reports on a URL
#
#   Usage:
#   m2-ligthouse $1 $2
#   Arguments:
#       $1  URL you wish to test
#       $2 (optional) Device you wish to test on mobile or desktop
#####################################################################

m2-lighthouse() {
    local URL=$1
    local DEVICE=mobile

    if [[ -n $2 ]]; then
        DEVICE=$2
    fi

    __echo_black "lighthouse $URL --chrome-flags=\"--ignore-certificate-errors\" --output\"json\" --output=\"html\" --output-path=./lighthouse-results --emulated-form-factor=\"$DEVICE\" --only-categories=performance,accessibility --view"
    lighthouse $URL --chrome-flags="--ignore-certificate-errors" --output="json" --output="html" --output-path=./lighthouse-results --emulated-form-factor="$DEVICE" --only-categories=performance,accessibility,best-practices,seo,pwa --view
}

#####################################################################
#   Runs a bash command in Magento Cloud and returns the result
#
#   Usage:
#   m2cloudcmd $1 $2
#   Arguments:
#       $1  Magento Cloud environment you wish to run command on
#       $2 Commmand you wish to run
#####################################################################

m2cloudcmd() {
    local MAGNETO_CLOUD_ENVIRONMENT=$1
    local CLOUD_COMMAND=$2
    __echo_black "magento-cloud environment:ssh --environment $MAGENTO_CLOUD_ENVIRONMENT -- \"$2\""
    magec environment:ssh --environment="$MAGENTO_CLOUD_ENVIRONMENT" -- $CLOUD_COMMAND
}

bmage-deploy-admin() {
    __echo_black "php -d memory_limit=-1 bin/magento setup:static-content:deploy --area=adminhtml --jobs=10 --force --symlink-locale --no-html-minify"
    php -d memory_limit=-1 bin/magento setup:static-content:deploy --area=adminhtml --jobs=10 --force --symlink-locale --no-html-minify
}