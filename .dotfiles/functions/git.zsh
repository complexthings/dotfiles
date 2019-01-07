git-update-release() {
    local RELEASE_NAME=$1
    local UNSTABLE=unstable/$RELEASE_NAME
    local STABLE=release/$RELEASE_NAME

    git fetch origin
    git checkout $STABLE
    git pull origin $STABLE
    git merge origin/$UNSTABLE
    git push origin $STABLE
}