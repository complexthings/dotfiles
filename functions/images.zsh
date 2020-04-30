# Image Optimization

#####################################################################
#   Media Optimization via command line using ImageOptim for Mac
#   optimizes the media in your current directory, or any path you
#   you pass it.
#
#   Usage:
#   optimize-images $1
#   Arguments:
#       $1  File system path to a directory with images.
#####################################################################

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

#####################################################################
#   Media Optimization via command line using ImageOptim for Mac
#   optimizes the media in an array of directories.
#
#   Usage:
#   optimize-images-all $1
#   Arguments:
#       $1  Array of directories to optimize images in.
#####################################################################

optimize-images-all() {
    local DIRECTORIES=(1 2 3 5 6 7 8 _ a b c d e f g h i j k l m n o p placeholder r s t u v w x y z)
    
    if [[ -n $1 ]]; then
        DIRECTORIES=$1
    fi
    
    for i in "${DIRECTORIES[@]}"
    do
        __echo_black "optimize-images $i/"
        optimize-images $i/
    done
}