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
alias cat="bat"
alias py="python3"
alias pythong="python3"
alias rm="trash"
alias ping="ping -c 5"
alias cp="cp -iv"
alias mv="mv -iv"
alias stat="stat -x"
alias grep="rg --color=always"

# Dirs
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
