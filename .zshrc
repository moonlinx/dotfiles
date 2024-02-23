# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Starship ----------------------------------------
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# System Aliases ----------------------------------------

alias l="eza -l --icons --git -a"
alias ls="eza --oneline --icons --long"
alias la="eza --icons --all"
alias lt="eza --tree --level=3 --long --icons --git"
alias t='tree -a'
alias vimm="vim"
alias x="exit"
alias gn="sudo shutdown -h now"
alias lt="ls -hT --color=always"
alias lock="pmset displaysleepnow"
alias cat="bat"
alias rm="trash"
alias c="clear"
alias z="zoxide"
alias sv="fd --type f --hidden --exclude .git | fzf-tmux -p --reverse | xargs nvim"

# Nmap
alias nm="nmap -sC -sV -oN nmap"

#git aliases
alias ga='git add -A'
alias gp='git push'
alias gl='git log'
alias gs='git status'
alias gdiff='git diff'
alias gdc='git diff --cached'
alias gcm='git commit -m'
alias gma='git commit -am'
alias gb='git branch'
alias gc='git checkout'
alias gra='git remote add'
alias grr='git remote rm'
alias gpl='git pull'
alias gcl='git clone'

# Dirs
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
# FUNCTIONS ___________________________________________
function take {
    mkdir -p $1
    cd $1
}
# ___________________________________________

# Pywal
export PATH="${PATH}:/Users/devindelaney/Library/Python/3.11/lib/python/site-packages"

# fzf base
export FZF_BASE=/path/to/fzf/install/dir

# fzf stuff ----------------------------------------
export FZF_DEFAULT_COMMAND='fd --type f --color=always'
export FZF_DEFAULT_OPS='--no-height --color=bg+:#343d46,gutter:-1,pointer:#ff3c3c,info:#0dbc79,hl:#0dbc79,hl+:#23d18b'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPS="--preview 'bat --color=always --line-range :50 {}'"

export FZF_ALT_C_COMMAND='fd --type d . --color=never --hidden'
export FZF_ALT_C_OPS="--preview 'tree -C {} | head -50'"

# Setting nvim as default editor ----------------------------------------
if [ $(command -v nvim) ]; then
  export EDITOR=$(which nvim)
  alias vim=$EDITOR
  alias v=$EDITOR
fi

export SUDO_EDITOR=$EDITOR
export VISUAL=$EDITOR
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPS="--extended"

export PATH="${PATH}:/Users/devindelaney/Library/Python/3.11/lib/python/site-packages"

# Sketchybar add for brew ----------------------------------------
function brew() {
  command brew "$@" 

  if [[ $* =~ "upgrade" ]] || [[ $* =~ "update" ]] || [[ $* =~ "outdated" ]]; then
    sketchybar --trigger brew_update
  fi
}

# - - - - - - - - - - - - - - - - - - - - -
# Run neofetch on opening
neofetch
# - - - - - - - - - - - - - - - - - - - - -
# spicetify path
export PATH=$PATH:/Users/devindelaney/.spicetify

# AUTOSUGGESTIONS___________________________________________

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^w' autosuggest-execute
bindkey '^e' autosuggest-accept
bindkey '^u' autosuggest-toggle
bindkey '^L' vi-forward-word
bindkey '^k' up-line-or-search
bindkey '^j' down-line-or-search


# SYYNTAX HIGHLIGHTING___________________________________________
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ZOXIDE___________________________________________
eval "$(zoxide init --cmd cd zsh)"
