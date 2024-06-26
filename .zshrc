# ---- Oh-my-posh ---- 
# ---- Prompt ----
# eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"
# #
# No terminal in apple terminal
#
# if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
#   eval "$(oh-my-posh init zsh)"
# fi

# Starship ----------------------------------------
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# FZF-Tab 
autoload -U compinit; compinit
source ~/.fzf-tab/fzf-tab.plugin.zsh
source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# System Aliases ----------------------------------------

alias l="eza -l --icons --git -a"
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias la="tree"
alias lt="eza --tree --level=2 --long --icons --git"
alias vimm="vim"
alias x="exit"
alias gn="sudo shutdown -h now"
alias lt="ls -hT --color=always"
alias lock="pmset displaysleepnow"
alias cat="bat"
alias rm="trash"
alias z="zoxide"
alias sv="fd --type f --hidden --exclude .git | fzf-tmux -p --reverse | xargs nvim"
alias ya="yazi"
alias d="delta"
alias yt="yt-dlp"
alias fetch="fastfetch"

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

# Docker
alias dco="docker compose"
alias dps="docker ps"
alias dpa="docker ps -a"
alias dl="docker ps -l -q"
alias dx="docker exec -it"

# Dirs
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
# FUNCTIONS ___________________________________________
#
#Create a directory and cd diretctly into it
function take {
    mkdir -p $1
    cd $1
}
# _____FZF_____


# fzf base
eval "$(fzf --zsh)"
# --- setup fzf theme ---
fg="#CBE0F0"
# bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

# fzf extras ----------------------------------------
# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}


# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

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

# - - - - - - - - - - - - - - - - - - - - -

# AUTOSUGGESTIONS___________________________________________

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^e' autosuggest-execute
# bindkey '^e' autosuggest-accept
bindkey '^u' autosuggest-toggle

# SYYNTAX HIGHLIGHTING___________________________________________
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ZOXIDE___________________________________________
eval "$(zoxide init --cmd cd zsh)"
# eval "$(atuin init zsh)"

# MANPAGES
# Colored manpages
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# FZF git
source ~/.fzf-git.sh/fzf-git.sh

eval "$(zoxide init zsh)"
