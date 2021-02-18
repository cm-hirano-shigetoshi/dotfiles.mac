#!/usr/bin/env bash
set -eu

DOTFILES=$(dirname $(python -c "import os; print(os.path.realpath('$0'))"))
HOME_BIN="$HOME/bin"
GIT_REPOSITORY_BASE="$HOME/OSS"
BREW_HOME="$(dirname $(dirname $(which brew)))"

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
    if ! which -a ls | grep -qF 'coreutils'; then
        brew install coreutils
    fi
    if ! which -a sed | grep -qF 'gnu-sed'; then
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
    ln -sf $DOTFILES/tmux.conf $HOME/.tmux.conf
}

zsh() {
    ln -sf $DOTFILES/zshrc $HOME/.zshrc
    ln -sf $DOTFILES/zprofile $HOME/.zprofile
}

vim() {
    rm -fr $HOME/.vim
    ln -s $DOTFILES/vim $HOME/.vim
    ln -sf $DOTFILES/vimrc $HOME/.vimrc
    if [[ ! -s ~/.vim/autoload/plug.vim ]]; then
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
                https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi
}

nvim() {
    if which nvim >/dev/null; then
        mkdir -p $HOME/.config
        rm -fr $HOME/.config/nvim
        ln -s $DOTFILES/nvim $HOME/.config/nvim
        mkdir -p $HOME/.nvim/backup
        if [[ ! -s $HOME/.local/share/nvim/site/autoload/plug.vim ]]; then
            sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
                   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        fi
    fi
}

python() {
    if [[ ! -s $BREW_HOME/bin/python3 ]]; then
        brew install python3
    fi
    ln -sf python3 $BREW_HOME/bin/python
    ln -sf pip3 $BREW_HOME/bin/pip
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
    if ! which jqable >/dev/null; then
        wget -O $HOME_BIN/master/jqable https://raw.githubusercontent.com/cm-hirano-shigetoshi/jqable/master/jqable
        chmod +x $HOME_BIN/master/jqable
    fi
    if ! which tovim >/dev/null; then
        wget -O $HOME_BIN/master/tovim https://raw.githubusercontent.com/cm-hirano-shigetoshi/tovim/master/tovim
        chmod +x $HOME_BIN/master/tovim
    fi
}

check
coreutils
fzf
karabiner
tmux
zsh
vim
nvim
python
convenient_tools
