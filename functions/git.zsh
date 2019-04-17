git-update-release() {
    local RELEASE_NAME=$1
    local UNSTABLE=unstable/$RELEASE_NAME
    local STABLE=release/$RELEASE_NAME

    __echo_black "git fetch origin"
    git fetch origin

    __echo_black "git checkout $STABLE"
    git checkout $STABLE

    __echo_black "git pull origin $STABLE"
    git pull origin $STABLE

    __echo_black "git merge origin/$UNSTABLE"
    git merge origin/$UNSTABLE

    __echo_black "git push origin $STABLE"
    git push origin $STABLE
}