#!/usr/bin/env bash
set -eu

DOTFILES=$(dirname $(python -c "import os; print(os.path.realpath('$0'))"))
HOME_BIN="$HOME/bin"
GIT_REPOSITORY_BASE="$HOME/OSS"

check() {
    if ! which brew >/dev/null 2>&1; then
        echo "[Error] brew is not installed" >&2
        exit 1
    fi
    if ! which git >/dev/null 2>&1; then
        echo "[Error] git is not installed" >&2
        exit 1
    fi
}

coreutils() {
    if ! brew list --formula | grep -qFx "coreutils"; then
        brew install coreutils
    fi
    if ! brew list --formula | grep -qFx "gnu-sed"; then
        brew install gnu-sed
    fi
    rm -f $HOME_BIN/master/uname
    ln -s /usr/bin/uname $HOME_BIN/master/uname
}

fzf() {
    if ! which fzf >/dev/null 2>&1; then
        brew install fzf
    fi
    if ! which fzfyml3 >/dev/null 2>&1; then
        mkdir -p "$GIT_REPOSITORY_BASE"
        cd "$GIT_REPOSITORY_BASE"
        git clone https://github.com/cm-hirano-shigetoshi/fzfyml3
        mkdir -p "$HOME_BIN/master" "$HOME_BIN/develop"
        rm -f $HOME_BIN/master/fzfyml3
        ln -s $GIT_REPOSITORY_BASE/fzfyml3/bin/fzfyml3 $HOME_BIN/master/fzfyml3
    fi
}


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

check
coreutils
fzf
karabiner
tmux
zsh
nvim
