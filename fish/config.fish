#
# ███████╗██╗███████╗██╗  ██╗
# ██╔════╝██║██╔════╝██║  ██║
# █████╗  ██║███████╗███████║
# ██╔══╝  ██║╚════██║██╔══██║
# ██║     ██║███████║██║  ██║
# ╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝
# A smart and user-friendly command line
# https://fishshell.com/
# cSpell:words shellcode pkgx direnv

# Nothing to do if not inside an interactive shell
if not status is-interactive
    return 0
end

# Remove the gretting message.
set -U fish_greeting

# Set up Ghostty's shell integration.
if test -n "$GHOSTTY_RESOURCES_DIR"
    source $GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish
end

eval (/opt/homebrew/bin/brew shellenv)

# starship init fish | source # https://starship.rs/
zoxide init fish | source # 'ajeetdsouza/zoxide'
fzf --fish | source # 'https://github.com/junegunn/fzf'

# Figure out which operating system we're in
set -l os (uname)

# System maintenance.
# abbr -a --position anywhere s sudo
# if test "$os" = Darwin
#     abbr -a --position anywhere b brew
# else if test "$os" = Linux
#     abbr -a j journalctl
#     abbr -a pc --position anywhere pacman
# end

# Add completions from stuff installed with Homebrew.
if test "$os" = Darwin
    if test -d (brew --prefix)"/share/fish/completions"
        set -p fish_complete_path (brew --prefix)/share/fish/completions
    end
    if test -d (brew --prefix)"/share/fish/vendor_completions.d"
        set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
    end
end

# $PATHS
fish_add_path $HOME/.config/scripts # my custom scripts

# Using Trash Command to replace rm
fish_add_path /opt/homebrew/opt/trash/bin:$PATH

# Set XDG config home
fish_add_path XDG_CONFIG_HOME=$HOME/.config

# Adding Python to path
fish_add_path /opt/homebrew/opt/python@3.13/libexec/bin:$PATH

fish_add_path /Users/fox/.local/bin:$PATH

# Use Nvim as the manpage viewer
export MANPAGER="nvim +Man!"

starship init fish | source # https://starship.rs/
