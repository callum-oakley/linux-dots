HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000

setopt SHARE_HISTORY
setopt INTERACTIVECOMMENTS

autoload -Uz compinit promptinit
compinit
promptinit

autoload -U colors
colors

autoload -U zmv

alias mmv="noglob zmv -W"
alias pi="pip3"
alias py="python3"
alias sed="gsed"
alias vi="nvim"
alias vim="nvim"
alias kc="kubectl"

autoload -U promptinit
promptinit
RPROMPT="%{`tput sitm`%}%D{%H:%M}%{`tput ritm`%}"

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
  PROMPT=$'\n'"%{[38;05;38m%}%1/ $separator %{$reset_color%}"
  zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

source <(kubectl completion zsh)

# brew install zsh-history-substring-search
source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=green'
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='fg=red'
export KEYTIMEOUT=1
export KUBECONFIG=kubeconfig
export VISUAL=nvim
export EDITOR="$VISUAL"
export GOPATH=$HOME/code/go
export PASSWORD_STORE_DIR="$HOME/Dropbox/.password-store"
export PATH=/Users/callum/.cargo/bin:/Users/callum/.local/bin:$GOPATH/bin:$PATH
source ~/.export-secrets
