#!/usr/bin/env bash
set -eu

DOTFILES=$(dirname $(python -c "import os; print(os.path.realpath('$0'))"))

tmux() {
    ln -sf $DOTFILES/.tmux.conf $HOME/.tmux.conf
}

zsh() {
    ln -sf $DOTFILES/.zshrc $HOME/.zshrc
    ln -sf $DOTFILES/.zprofile $HOME/.zprofile
}

nvim() {
    if ! which nvim >/dev/null 2>&1; then
        echo "[SKIP] Please install neovim"
        return
    fi
    mkdir -p $HOME/.config
    ln -sf $DOTFILES/nvim $HOME/.config/nvim
    mkdir -p $HOME/.nvim/backup
}

tmux
zsh
nvim
