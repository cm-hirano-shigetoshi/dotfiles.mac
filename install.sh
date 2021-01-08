#!/usr/bin/env bash
set -eu

DOTFILES=$(dirname $(python -c "import os; print(os.path.realpath('$0'))"))
HOME_BIN="$HOME/bin"
GIT_REPOSITORY_BASE="$HOME/OSS"

check() {
    if ! which brew >/dev/null; then
        echo "[Error] brew is not installed" >&2
        exit 1
    fi
    if ! which git >/dev/null; then
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
    if ! which fzf >/dev/null; then
        brew install fzf
    fi
    if ! which fzfyml3 >/dev/null; then
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
    cp $DOTFILES/karabiner.json $HOME/.config/karabiner/karabiner.json
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
    if ! which nvim >/dev/null; then
        echo "[SKIP] neovim is not installed"
    fi
}

pyenv() {
    if ! which pyenv >/dev/null; then
        git clone https://github.com/pyenv/pyenv.git ~/.pyenv
        git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
    fi
}

convenient_tools() {
    if ! which pwgen >/dev/null; then
        brew install pwgen
    fi
    if ! which watch >/dev/null; then
        wget -O $HOME_BIN/master/watch https://raw.githubusercontent.com/cm-hirano-shigetoshi/watch-zsh/master/watch
        chmod +x $HOME_BIN/master/watch
    fi
}

check
coreutils
fzf
karabiner
tmux
zsh
nvim
pyenv
convenient_tools
