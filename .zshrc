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

o_widget() {
  local dir
  dir=$(fd -t d | fzf) &&
  cd "$dir"
  zle reset-prompt
}

zle -N o_widget
bindkey '^o' o_widget

e_widget() {
  local file
  file=$(fd -t f | fzf) &&
  nvim "$file"
  zle reset-prompt
}

zle -N e_widget
bindkey '^e' e_widget

r_widget() {
  local result
  result=$(rg '.' --line-number --no-heading | fzf) &&
  nvim $(echo "$result" | awk -F: '{print $1 " +" $2}')
  zle reset-prompt
}

zle -N r_widget
bindkey '^r' r_widget

alias g='git checkout $(git branch | awk '\''!/\*/'\''| fzf)'
alias diff='colordiff -u'
alias dropbox='dropbox-cli'
alias ff='firefox-developer'
alias ghci='stack exec -- ghci'
alias git='hub'
alias gup='gup -t $GUP_TOKEN'
alias hy2py='hy2py3'
alias hy='hy --repl-output-fn=hy.contrib.hy-repr.hy-repr'
alias kc='kubectl'
alias kca='kubectl -n analytics'
alias kcc='kubectl -n chatkit'
alias kcf='kubectl -n feeds'
alias kcm='kubectl -n monitoring'
alias kcp='kubectl -n platform'
alias kcca='kubectl -n chatkit-acceptance'
alias l='cd $(cat $HOME/.wd) && pwd'
alias ls='ls --color=auto'
alias mix='pulsemixer'
alias mmv='noglob zmv -W'
alias open='xdg-open'
alias py='python'
alias rc='cat $(fd -tf)'
alias s='pwd > $HOME/.wd'
alias tree='tree -C'
alias vi='nvim'
alias vim='nvim'
alias xvi='xargs nvim'

source $HOME/.config/git-prompt.sh

RPROMPT='%F{red}$(__git_ps1 "%s")%f'

# enable full screen editing
autoload edit-command-line
zle -N edit-command-line

# zsh vi bindings config
bindkey -v
bindkey -M vicmd v edit-command-line

function n {
  if [[ $1 == pull ]]; then
    cd $HOME/notes
    git pull
  elif [[ $1 == push ]]; then
    cd $HOME/notes
    git add .
    git commit -m "$(date)"
    git push
  elif [[ $1 == '' ]]; then
    cd $HOME/notes
  fi
}

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

export FZF_DEFAULT_COMMAND='fd -t f'
export FZF_DEFAULT_OPTS='--reverse --height 16'
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=green'
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='fg=red'
export HISTORY_SUBSTRING_SEARCH_FUZZY=1
export KEYTIMEOUT=1
export KUBECONFIG="$HOME/.kube/config"
export VISUAL='nvim'
export EDITOR="$VISUAL"
export GOPATH="$HOME/code/go"
export PASSWORD_STORE_DIR="$HOME/.password-store"
export VAULT_ADDR='https://vault.pusherplatform.io:8200'
export PATH="$HOME/.cargo/bin:$GOPATH/bin:$GEM_HOME/bin:$HOME/.local/bin:$HOME/bin:$HOME/.yarn/bin:$PATH"
source "$HOME/.export-secrets"

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  startx
fi

tabs -4
