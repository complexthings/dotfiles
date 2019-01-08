downstream-dotfiles() {
    git clone git@github.com:complexthings/dotfiles.git ~/dotfiles-temp
    mv ~/dotfiles-tmp/.dotfiles ~/.dotfiles
    rm -rf ~/dotfiles-tmp
    zrefresh
}