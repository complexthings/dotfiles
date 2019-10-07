# Image Optimization

optimize-images() {
    local IMAGE_TYPES=( jpg jpeg gif png )
    local DIR=./

    if [[ -n $1 ]]; then
        DIR=$1
    fi

    for i in "${IMAGE_TYPES[@]}"
    do
        __echo_black "imageoptim '$1**/*.$i'"
        imageoptim "$1**/*.$i"
    done
}

optimize-images-all() {
    local DIRECTORIES=(0 1 2 3 5 6 7 a b c d e f F g G h i j k l m n o O p placeholder q r s t u v w y)
    
    for i in "${DIRECTORIES[@]}"
    do
        __echo_black "optimize-images $i/"
        optimize-images $i/
    done
}