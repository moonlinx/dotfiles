#  █████╗ ██████╗ ██████╗ ██████╗
# ██╔══██╗██╔══██╗██╔══██╗██╔══██╗
# ███████║██████╔╝██████╔╝██████╔╝
# ██╔══██║██╔══██╗██╔══██╗██╔══██╗
# ██║  ██║██████╔╝██████╔╝██║  ██║
# ╚═╝  ╚═╝╚═════╝ ╚═════╝ ╚═╝  ╚═╝
# abbreviations - user-defined words that are replaced with longer phrases when entered
# https://fishshell.com/docs/current/cmds/abbr.html
# cSpell:disable

# Brew
abbr bi "brew install"
abbr bic "brew install --cask"
abbr bin "brew info"
abbr binc "brew info --cask"
abbr bl "brew leaves"
abbr blr "brew leaves --installed-on-request"
abbr blp "brew leaves --installed-as-dependency"
abbr bs "brew search"

# Neovim.
abbr -a nv nvim
abbr -a nvp nvim +Man!

abbr s sesh_start
abbr s. "sesh connect ."
abbr sc "sesh clone --cmdDir ~/c (pbpaste)"
abbr sf "source ~/.config/fish/config.fish"
abbr sr "sesh root"

# Vi mode.
set -g fish_key_bindings fish_vi_key_bindings
set fish_vi_force_cursor 1
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore

# Git abbreviations.
abbr -a g git
abbr -a ga git add -A
abbr -a gp git push
abbr -a gpl git pull
abbr -a gcl git clone
abbr -a gb git branch
abbr -a gcm git commit
abbr -a gco git checkout
abbr -a gf git fetch
abbr -a gl lazygit
abbr -a gm git merge
abbr -a gst git status
