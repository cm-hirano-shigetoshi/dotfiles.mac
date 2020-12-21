if [[ -n $TMUX ]]; then
  #
  # Zinitのおまじない
  #
  ### Added by Zinit's installer
  if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
      print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
      command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
      command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
          print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
          print -P "%F{160}▓▒░ The clone has failed.%f%b"
  fi

  source "$HOME/.zinit/bin/zinit.zsh"
  autoload -Uz _zinit
  (( ${+_comps} )) && _comps[zinit]=_zinit
  ### End of Zinit's installer chunk

  #
  # プラグインインストール
  #
  # ディレクトリスタック
  zinit ice wait'!0' src"directory.zsh" silent; zinit light cm-hirano-shigetoshi/directory-stack
  # コマンド履歴
  zinit ice wait'!0' src"history.zsh" silent; zinit light cm-hirano-shigetoshi/command-history
  # gitのステータス表示（PROMPTにgit_super_statusを入れて初めて効果が出る）
  zinit ice src"zshrc.sh"; zinit light olivierverdier/zsh-git-prompt
  PROMPT='[%{$fg[green]%}%n@%m %{$fg[yellow]%}%d%{$reset_color%}]$(git_super_status)'$'\n''$ '
  # コマンドに色を付ける
  zinit ice wait'!0' silent; zinit light zdharma/fast-syntax-highlighting
  # fzfymlのインストール
  #     PATHに直接追加するのか、シンボリックリンクにするかを考える
  zinit ice wait'!0' as"program" pick"bin/fzfyml3" silent; zinit light cm-hirano-shigetoshi/fzfyml3
  # クリップボード履歴
  zinit ice wait'!0' silent; zinit light cm-hirano-shigetoshi/clipboard-history
  # スニペットの貼り付け機能
  zinit ice wait'!0' silent; zinit light cm-hirano-shigetoshi/snippet
  # ファイル名検索
  zinit ice wait'!0' src"select-files.zsh" silent; zinit light cm-hirano-shigetoshi/select-files
  # aws cliコマンド拡張
  #zinit ice wait'!0' src"fzf-aws-help.zsh" silent; zinit light cm-hirano-shigetoshi/fzf-aws-help
  # git
  zinit ice wait'!0' src"git.zsh" silent; zinit light cm-hirano-shigetoshi/fzf-git
  # Ninja
  zinit ice wait'!0' src"ninja.zsh" silent; zinit light cm-hirano-shigetoshi/cli-ninja

  #
  # 環境変数的なもの
  #
  if [[ $(uname -m) = "arm64" ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
  fi
  if [[ $(uname -m) = "arm64" ]]; then
    export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
    export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"
  fi

  #
  # 一般の設定
  #
  # Ctrl+s（ターミナルロック）を無効化。これがないとCtrl+sを含むキーバインドが無効になる。
  stty stop undef
  # Ctrl+d でターミナルを閉じないようにする
  setopt IGNOREEOF
  # executableなファイルをbin/masterに置く
  PATH=":$HOME/bin/master:$PATH"
  # 実験中のファイルはbin/developに置く
  PATH="$HOME/bin/develop:$PATH"
  # 特殊文字の中で「単語」の境界として扱う文字を指定
  WORDCHARS="*?.-_[]~&;!#$%^(){}<>"
  # ヒストリにはスペースなどを整形した状態で保存する
  setopt hist_reduce_blanks
  # 直前と同じヒストリは記録しない
  setopt hist_ignore_dups

  #
  # 補完の設定
  #
  # zsh の補完機能を使うおまじない
  autoload -Uz compinit
  compinit -C
  # 補完候補にも色を付ける
  zstyle ':completion:*' list-colors 'di=34;1'
  # ファイル名の途中でも補完候補とし、小文字は大文字としても検索
  zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'l:|=* r:|[.-]=* m:{a-z}={A-Z}'

  #
  # 一時的な設定
  #
  if [[ $(uname -m) = "arm64" ]]; then
    alias ls='ls --color=auto'
  else
    alias ls='ls -G'
  fi
  if which nvim >/dev/null 2>&1; then
    alias vim='nvim'
  fi

  #
  # fzfの設定
  #
  FZF_DEFAULT_OPTS=""
  FZF_DEFAULT_OPTS+=" --exact --no-mouse --ansi"
  FZF_DEFAULT_OPTS+=" --preview-window=up:wrap"
  FZF_DEFAULT_OPTS+=" --preview='echo {}'"
  FZF_DEFAULT_OPTS+=" --bind='ctrl-s:toggle-sort'"
  export FZF_DEFAULT_OPTS


  if [[ $(uname -m) != "arm64" ]]; then
    export PYENV_ROOT="${HOME}/.pyenv"
    export PATH="${PYENV_ROOT}/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
  fi
fi
