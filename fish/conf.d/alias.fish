#  █████╗ ██╗     ██╗ █████╗ ███████╗
# ██╔══██╗██║     ██║██╔══██╗██╔════╝
# ███████║██║     ██║███████║███████╗
# ██╔══██║██║     ██║██╔══██║╚════██║
# ██║  ██║███████╗██║██║  ██║███████║
# ╚═╝  ╚═╝╚══════╝╚═╝╚═╝  ╚═╝╚══════╝
# A simple wrapper for the function builtin, which creates a function wrapping a command
# https://fishshell.com/docs/current/cmds/alias.html

alias ll="eza -l --icons --git "
alias ls="eza --color=always --grid --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias la="eza -a"
alias lt="eza --tree --level=2 --long --icons --git"
alias vimm="vim"
alias x="exit"
alias gn="sudo shutdown -h now"
alias cat="bat"
alias z="zoxide"
alias sv="fd --type f --hidden --exclude .git | fzf-tmux -p --reverse | xargs nvim"
alias ya="yazi"
alias d="delta"
alias yt="yt-dlp"
alias f="fastfetch"
alias sp="spotify_player"
alias wifi="wifi-password"
alias py="python3"
alias rm="trash"
alias ping="ping -c 5"
alias cp="cp -iv"
alias mv="mv -iv"

# Sesh
alias s="./.config/scripts/sesh_start"

# Nmap
alias nm="nmap -sC -sV -oN nmap-output.txt"

# Dirs
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
