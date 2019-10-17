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