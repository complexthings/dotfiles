downstream-dotfiles() {
    __echo_black "git clone git@github.com:complexthings/dotfiles.git ~/dotfiles-temp"
    git clone git@github.com:complexthings/dotfiles.git ~/dotfiles-temp

    __echo_black "mv ~/dotfiles-tmp ~/.dotfiles"
    mv ~/dotfiles-tmp ~/.dotfiles

    __echo_black "rm -rf ~/dotfiles-tmp"
    rm -rf ~/dotfiles-tmp

    __echo_black "zrefresh"
    zrefresh
}