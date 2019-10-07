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
                    DESTINATION_APP=pstorm
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

noa-image() {
    scp 1.ent-h7ech7u2dkwus-staging-5em2ouy@ssh.us-3.magento.cloud:$1 $1
}

noa-detect-images() {
    local MY_IMAGES=( /1/0/105214.jpg /1/0/105215.jpg /1/0/102530.jpg /1/0/102450.jpg /1/0/104480.jpg /1/0/105641.jpg /1/0/103387.jpg /1/0/108040.jpg /1/0/108041.jpg /1/0/108093.jpg /1/0/108092.jpg /1/0/102171.jpg /1/0/102302.jpg /1/0/100234.jpg /1/0/100235.jpg /7/7/77623.jpg /1/0/106826.jpg /1/0/106825.jpg /1/0/103533.jpg /1/0/103532.jpg /8/0/80911.jpg /1/0/103591.jpg /1/0/107137.jpg /1/0/106171.jpg /1/0/107645.jpg /1/0/103590.jpg /1/0/107741.jpg /1/0/108300.jpg /1/0/105714.jpg /1/0/105562.jpg /1/0/106392.jpg /1/0/106405.jpg /1/0/106404.jpg /1/0/108293.jpg /1/0/100230.jpg /1/0/100229.jpg /1/0/108296.jpg /1/0/104636.jpg /1/0/104635.jpg /1/0/103358.jpg /1/0/103359.jpg /1/0/107773.jpg /1/0/107772.jpg /1/0/106080.jpg /1/0/106079.jpg /1/0/103606.jpg /1/0/103605.jpg /1/0/108062.jpg /1/0/108061.jpg /1/0/108087.jpg /1/0/108086.jpg /6/2/62612.jpg /1/0/108385.jpg /1/0/108591.jpg /1/0/108383.jpg /1/0/106987.jpg /1/0/106989.jpg /1/0/107534.jpg /1/1/110528.jpg /1/0/104900.jpg /1/1/111125.jpg /1/0/108143.jpg /1/0/107598.jpg /1/0/105674.jpg /1/0/105615.jpg /1/0/105737.jpg /1/0/104947.jpg /1/0/105649.jpg /1/0/104876.jpg /1/0/104874.jpg /1/0/105647.jpg /1/0/104890.jpg /1/1/111124.jpg /1/0/104878.jpg /1/0/107377.jpg /1/0/105440.jpg /1/0/108342.jpg /1/1/110522.jpg /1/0/107661.jpg /1/0/107780.jpg /1/1/110030.jpg /1/1/110031.jpg /1/0/105606.jpg /1/1/110514.jpg /1/1/110512.jpg /1/0/105605.jpg /1/0/105616.jpg /1/0/105617.jpg /1/0/107653.jpg /1/1/110527.jpg /1/1/110526.jpg /1/1/110525.jpg /1/1/110467.jpg /1/1/110524.jpg /1/0/106522.jpg /1/0/106524.jpg /1/0/105609.jpg /1/0/108720.jpg /1/0/108721.jpg /1/0/108724.jpg /1/0/108723.jpg /1/0/108722.jpg /1/0/108054.jpg /1/0/108050.jpg /1/0/108051.jpg /1/0/108052.jpg /1/0/108053.jpg /1/0/108070.jpg /1/0/108067.jpg /1/0/108059.jpg /1/0/108066.jpg /1/0/108065.jpg /1/0/108056.jpg /1/0/109484.jpg /1/0/109488.jpg /1/0/109485.jpg /1/0/109487.jpg /1/0/109486.jpg /1/0/107660.jpg /1/0/104121.jpg /1/0/104122.jpg /1/0/106103.jpg /1/0/106104.jpg /1/0/108083.jpg /1/0/103277.jpg /1/0/100094.jpg /7/5/75449.jpg /1/0/105276.jpg /1/0/105275.jpg /1/0/104171.jpg /1/0/104172.jpg /1/0/106504.jpg /1/0/106503.jpg /7/6/76988.jpg /1/0/104619.jpg /1/0/104620.jpg /1/0/103636.jpg /1/0/107730.jpg /1/0/107729.jpg /7/6/76548.jpg /1/0/108389.jpg /1/0/103819.jpg /1/0/106102.jpg /1/0/104926.jpg /1/0/104927.jpg /1/0/106679.jpg /1/0/106399.jpg /1/0/106077.jpg /7/7/77332.jpg /7/7/77331.jpg /7/7/77728.jpg /1/0/100213.jpg /1/0/107749.jpg /1/0/107750.jpg /1/0/107283.jpg /1/0/103878.jpg /7/8/78880.jpg /1/0/104117.jpg /1/0/103853.jpg /1/0/103852.jpg /1/0/103846.jpg /1/0/102417.jpg /1/0/102416.jpg /1/0/106411.jpg /1/0/106412.jpg /1/0/106408.jpg /8/0/80738.jpg /8/0/80743.jpg /1/0/108324.jpg /1/0/108323.jpg /1/0/108308.jpg /1/0/108307.jpg /1/0/106073.jpg /1/0/102502.jpg /1/0/104628.jpg /1/0/106838.jpg /7/6/76545.jpg /1/0/105636.jpg /1/0/103733.jpg /1/0/105635.jpg /1/0/102286.jpg /1/0/108789.jpg /1/1/110018.jpg /1/1/110019.jpg /1/0/103859.jpg /7/7/77726.jpg /7/7/77875.jpg /1/0/103667.jpg /1/0/103416.jpg /7/5/75446.jpg /1/1/110236.jpg /1/1/110237.jpg /1/1/110687.jpg /1/1/110479.jpg /1/0/105880.jpg /1/0/105879.jpg /1/0/108794.jpg /1/0/108392.jpg /7/8/78645.jpg /8/3/83562.jpg /1/0/108043.jpg /1/0/108044.jpg /1/0/107474.jpg /1/0/107680.jpg /1/0/106414.jpg /1/0/106415.jpg /1/0/103633.jpg /1/0/103618.jpg /1/1/110013.jpg /1/0/107553.jpg /8/3/83571.jpg /1/0/107554.jpg /1/0/105208.jpg /1/0/105209.jpg /1/1/110009.jpg /1/0/103421.jpg /1/0/103585.jpg /1/0/103586.jpg /1/0/102476.jpg /1/0/103873.jpg /1/0/105575.jpg /1/0/108047.jpg /1/0/108046.jpg /8/1/81886.jpg /1/0/101331.jpg /1/0/106469.jpg /1/0/106470.jpg /1/0/102521.jpg /1/0/104094.jpg /1/0/104095.jpg /1/0/104092.jpg /6/3/63727.jpg /6/8/68623.jpg /7/8/78909.jpg /7/8/78908.jpg /8/3/83574.jpg /6/3/63724.jpg /8/1/81998.jpg /8/1/81997.jpg /1/0/103128.jpg /7/0/70298.jpg /7/0/70809.jpg /7/3/73379.jpg /7/9/79586.jpg /6/8/68508.jpg /6/8/68509.jpg /7/7/77423.jpg /7/3/73997.jpg /7/0/70333.jpg /7/2/72003.jpg /7/6/76918.jpg /7/9/79587.jpg /7/1/71697.jpg /7/9/79584.jpg /6/1/61114.jpg /7/4/74031.jpg /1/0/102095.jpg /1/0/102094.jpg /7/4/74034.jpg /7/9/79583.jpg /7/6/76148.jpg /7/4/74314.jpg /7/0/70308.jpg /7/9/79598.jpg /7/9/79580.jpg /1/0/107331.jpg /1/0/107533.jpg /1/0/107330.jpg /7/2/72939.jpg /6/4/64549.jpg /1/0/101350.jpg /1/0/108305.jpg /7/1/71694.jpg /1/0/101753.jpg /7/9/79582.jpg /1/0/102511.jpg /1/0/106729.jpg /7/7/77419.jpg /1/0/102052.jpg /7/9/79590.jpg /8/2/82565.jpg /7/3/73036.jpg /6/9/69833.jpg /7/3/73006.jpg /1/0/107619.jpg /1/0/102467.jpg /7/9/79595.jpg /1/0/103584.jpg /7/6/76523.jpg /1/0/106353.jpg /1/0/102183.jpg /1/0/104849.jpg /1/0/100452.jpg /1/0/105005.jpg /1/0/105004.jpg /1/0/106817.jpg /1/0/107298.jpg /1/0/102720.jpg /1/0/103674.jpg /1/0/103994.jpg /1/0/104822.jpg /1/0/107093.jpg /1/0/104708.jpg /1/0/107613.jpg /1/0/107577.jpg /1/0/107367.jpg /1/1/110515.jpg /1/0/102465.jpg /1/0/107301.jpg /1/0/105070.jpg /1/0/105071.jpg /1/0/102597.jpg /1/0/104616.jpg /1/0/102735.jpg /1/0/108109.jpg /1/0/107373.jpg /1/0/101919.jpg /1/0/100328.jpg /1/0/107371.jpg /1/0/101281.jpg /1/1/110921.jpg /1/1/110923.jpg /1/0/107445.jpg /1/0/107447.jpg /1/0/105446.jpg /1/0/105703.jpg /1/0/109990.jpg /1/0/104894.jpg /1/0/104896.jpg /1/0/104898.jpg /1/0/105444.jpg /1/0/109989.jpg /1/0/105088.jpg /1/0/105859.jpg /1/0/103526.jpg /1/0/107845.jpg /1/1/110519.jpg /1/1/110518.jpg /1/1/110517.jpg /1/0/107844.jpg /1/0/107843.jpg /1/0/107370.jpg /1/0/107576.jpg /1/0/107375.jpg /1/0/108110.jpg /1/0/107362.jpg /1/0/108683.jpg /1/0/107822.jpg /1/0/107491.jpg /1/0/107473.jpg /1/0/107492.jpg /1/0/107494.jpg /1/0/108107.jpg /1/0/108105.jpg /1/0/107299.jpg /1/1/110568.jpg /7/7/77944.jpg /1/0/107366.jpg /1/0/107368.jpg /1/0/107502.jpg /1/0/108112.jpg /1/0/108114.jpg /1/0/108727.jpg /1/0/107376.jpg /1/0/107511.jpg /6/5/65491.jpg /6/2/62616.jpg /1/0/100997.jpg /1/1/110930.jpg /1/1/110929.jpg /1/1/110928.jpg /1/1/110932.jpg /1/1/110933.jpg /1/1/110934.jpg /1/1/110920.jpg /1/0/106547.jpg /1/1/110924.jpg /1/0/105213.jpg /1/0/107632.jpg /1/0/109884.jpg /1/0/107827.jpg /1/0/108726.jpg /1/0/107396.jpg /1/0/107444.jpg /1/0/108914.jpg /1/0/109430.jpg /1/0/108713.jpg /1/0/108910.jpg /1/0/108129.jpg /1/0/108603.jpg /1/0/108602.jpg /1/0/108601.jpg /1/0/108604.jpg /1/0/108605.jpg /1/0/108116.jpg /1/0/1000x1000_nesc_storeimages_package.jpg /1/0/1000x1000_nesc_storeimages_controllers.jpg /1/0/1000x1000_nesc_storeimages_diagram.jpg /1/0/1000x1000_nesc_storeimages_nexttoswitch.jpg /1/0/1000x1000_nesc_storeimages_withswitch.jpg /1/1/111703-111709.jpg /1/1/111703-111709alt2.jpg /1/1/111703-111709alt1.jpg /1/1/111710-111717.jpg /1/1/111710-111717alt1.jpg /1/1/111710-111717alt2.jpg /1/1/111710-111717alt3.jpg /m/m/mm2.jpg /m/m/mm2_1.jpg /u/n/unknownskualt3.jpg /u/n/unknownsku.jpg /u/n/unknownskualt1.jpg /u/n/unknownskualt2.jpg )

    for i in "${MY_IMAGES[@]}"
    do
        if [[ -f "pub/media/catalog/product$i" ]]; then
            echo "$i exist"
        else
            echo "$i needs to be download"
            # noa-image pub/media/catalog/product$1
        fi  
    done
}