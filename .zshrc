# .zshrc
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
bindkey -e
# End of lines configured by zsh-newuser-install

autoload -Uz compinit promptinit
compinit
promptinit

autoload -U colors
colors

autoload -U zmv

alias mmv="noglob zmv -W"
alias sed="gsed"
alias vi="nvim"
alias vim="nvim"

autoload -U promptinit
promptinit

# Commands for the current directory to display in title
precmd () {print -Pn "\e]2; %~/ \a"}
preexec () {print -Pn "\e]2; %~/ \a"}

# zsh vi bindings config
bindkey -v

function zle-line-init zle-keymap-select {
  if [[ $KEYMAP == vicmd ]]; then
    PROMPT="%{[38;05;38m%}%1~ → %{$reset_color%}"
  elif [[ $KEYMAP == main ]] || [[ $KEYMAP == viins ]] || [[ $KEYMAP = '' ]]; then
    PROMPT="%{[38;05;38m%}%1~ $ %{$reset_color%}"
  fi
  zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1

export VISUAL=nvim
export EDITOR="$VISUAL"
export PATH=/Users/callum/.cargo/bin:/Users/callum/.local/bin:$PATH

