# SITES
# -----------------------------------

#####################################################################
#   Opens Sites Directory (var/www), Project within Sites Directory 
#   (var/www/{PROJECT}) and launches IDE for Project
#   Usage:
#   g2sites $1 $2
#   Arguments:
#       $1  (optional) Site Directory that Exists within /var/www
#       $2  (optional) Languages/Platform you want to open IDE for.
#           php    Opens project in PHPStorm
#           js     Opens project in Webstorm
#           code   Opens project in VSCode
#           [Any Other Characters] Opens project in VSCode
#####################################################################
g2sites() {
    if [[ -n $1 ]]
    then
        if [[ -n $2 ]]
        then
            local DESTINATION_DIRECTORY=$BA_SITES_DIR/$1
            local DESTINATION_APP=code
            local DESTINATION_APP_NAME="Visual Studio Code"

            case $2 in
                php)
                    DESTINATION_APP=phpstorm
                    DESTINATION_APP_NAME="PHPStorm"
                    ;;
                js)
                    DESTINATION_APP=webstorm
                    DESTINATION_APP_NAME="WebStorm"
                    ;;
                code)
                    ;;
                *)
                    ;;
            esac

            echo "Openning the Project in $DESTINATION_APP_NAME"

            __echo_black "cd $DESTINATION_DIRECTORY && $DESTINATION_APP ."

            cd $DESTINATION_DIRECTORY && $DESTINATION_APP .
        else

            __echo_black "cd $BA_SITES_DIR/$1"
            cd $BA_SITES_DIR/$1
        fi
    else
        echo "Going to Sites"

        __echo_black "cd $BA_SITES_DIR"
        cd $BA_SITES_DIR
    fi
}