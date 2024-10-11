![mr-fox-dotfiles](https://github.com/user-attachments/assets/5d1a16c9-8c86-45f3-9917-6b3d2d3ba7ae)

# .dotfiles

Dotfiles for my M3 Max Macbook Pro: Running macOS Sonoma 14.6.

- Terminal: [Wezterm](https://github.com/wez/wezterm) using zsh w/ [starship prompt](https://github.com/starship/starship) and [eza](https://github.com/eza-community/eza)
- Window Management: [yabai](https://github.com/koekeishiya/yabai) and [JankyBorders](https://github.com/FelixKratz/JankyBorders)
- Bar: [Sketchybar](https://github.com/FelixKratz/SketchyBar)
- File Management: [yazi](https://github.com/sxyazi/yazi)
- Hotkeys: [skhd](https://github.com/koekeishiya/skhd)
- Vim: [neovim](https://neovim.io) / [lazyvim](https://github.com/LazyVim/LazyVim) to manage plugins
- Tools: [tmux](https://github.com/tmux/tmux), [zoxide](https://github.com/ajeetdsouza/zoxide), [fzf](https://github.com/junegunn/fzf)

## Installation

**Before you get started** make sure you give full disk access permission to your terminal (for writing macos defaults). `System Preferences -> Privacy -> Full Disk Access`.

```sh
stow --target ~/.config
```

### Homebrew installation:

```sh
# Leaving a machine
brew leaves > leaves.txt

# Fresh installation
xargs brew install < leaves.txt
```

## Installation

**Before you get started** make sure you give full disk access permission to your terminal (for writing macos defaults). `System Preferences -> Privacy -> Full Disk Access`.

To install:

`curl -L https://git.io/JeA7g | sh`

This expands to [run.sh](https://github.com/gretzky/dotfiles/blob/master/run.sh) which will fetch this repo and run the install script.

## File overview

- Configs for the following tools:
  - git
  - [Wezterm](./wezterm)
  - [colorls](./colorls)
  - [fzf](./fzf)
  - [neovim](./nvim)
  - [skhd](./skhd)
  - [starship](./starship)
  - [tmux](./tmux)
  - [VSCode](./vscode)
  - [yabai](./yabai)
  - [z](./z)
- Shell environment configs:
  - [Antigen](https://github.com/zsh-users/antigen) for zsh plugin management
  - [`.zshrc`](./zsh/.zshrc)
  - [`.zlogin.sh`](./zsh/.zlogin.sh)
  - [`.zshenv.sh`](./zsh/.zshenv.sh)
  - [`.aliases`](./zsh/.aliases)
  - [`.exports`](./zsh/.exports)
- [`Brewfile`](./Brewfile) - contains all homebrew packages, casks, and mac appstore apps
- [VSCode settings](./vscode/settings.json)

The install script will also setup Python and Node versions/environments:

- [pyenv](https://github.com/pyenv/pyenv) sets the global Python version to 3.12
- [n](https://github.com/tj/n) sets the global Node version to LTS

### Customization

#### Git

- Be sure to update the user name/email values in the global [gitconfig](./git/.gitconfig)

#### Color Schemes

- Wezterm color scheme is [Catppuccin - Machiatto](https://github.com/catppuccin/wezterm)
- Neovim color scheme is [Catppuccin - Mocha]()

## Acknowledgements

- [huyvohcmc/dotfiles](https://github.com/huyvohcmc/dotfiles)
- [alrra/dotfiles](https://github.com/alrra/dotfiles)
- [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
- [gretzky/dotfiles](https://github.com/gretzky/dotfiles)
