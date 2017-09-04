HISTFILE=$HOME/.histfile
HISTSIZE=1000000
SAVEHIST=1000000

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

setopt HIST_IGNORE_ALL_DUPS
setopt INTERACTIVECOMMENTS
setopt PROMPT_SUBST
setopt SHARE_HISTORY

autoload -Uz compinit promptinit
compinit
promptinit

autoload -U colors
colors

autoload -U zmv

alias core="vi $HOME/notes/core"
alias kc="kubectl"
alias mmv="noglob zmv -W"
alias pi="pip3"
alias py="python3"
alias sed="gsed"
alias vi="nvim"
alias vim="nvim"
alias tree="tree -C"

source $HOME/.config/git-prompt.sh

RPROMPT='%F{red}$(__git_ps1 "%s")%f'

# Commands for the current directory to display in title
precmd () {print -Pn "\e]0; %1/ \a"}
preexec () {print -Pn "\e]0; %1/ \a"}

# enable full screen editing
autoload edit-command-line
zle -N edit-command-line

# zsh vi bindings config
bindkey -v
bindkey "^R" history-incremental-search-backward
bindkey -M vicmd v edit-command-line

function zle-line-init zle-keymap-select {
  if [[ $KEYMAP == vicmd ]]; then
    separator="!"
  elif [[ $KEYMAP == main ]] || [[ $KEYMAP == viins ]] || [[ $KEYMAP = '' ]]; then
    separator="$"
  fi
  PROMPT=$'\n'"%F{red}%1/ $separator %f"
  zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

source $HOME/bin/zsh-history-substring-search.zsh

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=green'
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='fg=red'
export HISTORY_SUBSTRING_SEARCH_FUZZY=1
export KEYTIMEOUT=1
export KUBECONFIG=kubeconfig
export VISUAL=nvim
export EDITOR="$VISUAL"
export GOPATH=$HOME/code/go
export PASSWORD_STORE_DIR="$HOME/Dropbox/.password-store"
export PATH=/usr/local/opt/curl/bin:/Users/callum/.cargo/bin:/Users/callum/.local/bin:$GOPATH/bin:/Users/callum/Library/Haskell/bin:/Users/callum/.cabal/bin:$PATH
source $HOME/.export-secrets
