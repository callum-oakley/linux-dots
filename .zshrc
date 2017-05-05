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

function vin() {
  vi ~/notes/$1.md
}

function ta() {
  echo "[${2:+#}$2"#`date +%F#%R#`] $1 >> ~/notes/.t
}

function tat() {
  echo "[#todo${2:+#}$2"#`date +%F#%R#`] $1 >> ~/notes/.t
}

function tl() {
  cat ~/notes/.t
}

function tf() {
  grep -i "${2+#}$1#"
}

function tc() {
  cut -d ' ' -f 2-
}

function t() {
  tl | tf $1 | tf $2 | tf $3 | tf $4 | tf $5 | tf $6 | tf $7 | tf $8 | tc
}

function tt() {
  tl | tf todo | tf $1 | tf $2 | tf $3 | tf $4 | tf $5 | tf $6 | tf $7 | tc
}

function tv() {
  vi ~/notes/.t
}

autoload -U promptinit
promptinit
RPROMPT="%{`tput sitm`%}%D{%H:%M}%{`tput ritm`%}"

# Commands for the current directory to display in title
precmd () {print -Pn "\e]2; %1/ \a"}
preexec () {print -Pn "\e]2; %1/ \a"}

# zsh vi bindings config
bindkey -v
bindkey "^R" history-incremental-search-backward

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
export KEYTIMEOUT=1

export VISUAL=nvim
export EDITOR="$VISUAL"
export GOPATH=$HOME/code/go
export PATH=/Users/callum/.cargo/bin:/Users/callum/.local/bin:$GOPATH/bin:$PATH

