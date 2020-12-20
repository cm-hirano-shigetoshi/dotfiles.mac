#!/usr/bin/env bash
set -eu

DOTFILES=$(dirname $(python -c "import os; print(os.path.realpath('$0'))"))

karabiner() {
    mkdir -p $HOME/.config/karabiner
    ln -sf $DOTFILES/karabiner.json $HOME/.config/karabiner/karabiner.json
}

tmux() {
    ln -sf $DOTFILES/.tmux.conf $HOME/.tmux.conf
}

zsh() {
    ln -sf $DOTFILES/.zshrc $HOME/.zshrc
    ln -sf $DOTFILES/.zprofile $HOME/.zprofile
}

nvim() {
    mkdir -p $HOME/.config
    rm -fr $HOME/.config/nvim
    ln -s $DOTFILES/nvim $HOME/.config/nvim
    mkdir -p $HOME/.nvim/backup
    if ! which nvim >/dev/null 2>&1; then
        echo "[SKIP] neovim is not installed"
    fi
}

karabiner
tmux
zsh
nvim
