downstream-dotfiles() {
    git clone git@github.com:complexthings/dotfiles.git ~/dotfiles-temp
    mv ~/dotfiles-tmp/.dotfiles ~/.dotfiles
    cp ~/dotfiles-tmp/.zshrc ~/.zshrc
    rm -rf ~/dotfiles-tmp
}