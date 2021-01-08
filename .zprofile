if echo $SHELL | grep -qF 'zsh'; then
    typeset -U path PATH
fi

export DOTFILES="$HOME/dotfiles.mac"

export FZFYML3_PYTHON="/opt/homebrew/bin/python3"
FZF_DEFAULT_OPTS=""
FZF_DEFAULT_OPTS+=" --exact --no-mouse --ansi"
FZF_DEFAULT_OPTS+=" --preview-window=up:wrap"
FZF_DEFAULT_OPTS+=" --preview='echo {}'"
FZF_DEFAULT_OPTS+=" --bind='ctrl-s:toggle-sort'"
export FZF_DEFAULT_OPTS

if [[ $(uname -m) = "arm64" ]]; then
    PATH="/opt/homebrew_x86/bin:$PATH"
    PATH="/opt/homebrew/bin:$PATH"
    PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
    PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"
else
    PATH="/opt/homebrew_x86/bin:$PATH"
    PATH="/opt/homebrew_x86/opt/coreutils/libexec/gnubin:$PATH"
    PATH="/opt/homebrew_x86/opt/gnu-sed/libexec/gnubin:$PATH"
fi
PATH="$HOME/bin/master:$PATH"

if [[ -s $HOME/company/.profile ]]; then
    source $HOME/company/.profile
fi

