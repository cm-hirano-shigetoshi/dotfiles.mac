if echo $SHELL | grep -qF 'zsh'; then
    typeset -U path PATH
fi

export DOTFILES="$HOME/dotfiles.mac"

PATH="$HOME/bin/master:$PATH"
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

