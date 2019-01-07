# Docker
# ---------------------------------------

docker-set-env(){
    eval $(docker-machine env $1)
}

docker-api-version(){
    export DOCKER_API_VERSION=$1
}