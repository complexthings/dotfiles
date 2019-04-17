# Docker
# ---------------------------------------

docker-set-env(){
    __echo_black "eval $(docker-machine env $1)"
    eval $(docker-machine env $1)
}

docker-api-version(){
    __echo_black "export DOCKER_API_VERSION=$1"
    export DOCKER_API_VERSION=$1
}