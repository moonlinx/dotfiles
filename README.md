# (.)files

Personal MacOS dotfile congigurations.
<img width="2556" alt="sketchybar_minimal" src="https://github.com/erihome/dotfiles/assets/49962728/a7ade506-62dd-4d70-89ab-6d5da0e92374">

Normal navigation with vim navigation customized for terminal applications.

### Installs

- [Sketchybar](https://github.com/FelixKratz/SketchyBar)
- [yabai](https://github.com/koekeishiya/yabai)
- [skhd](https://github.com/koekeishiya/skhd)
  [JankyBorders](https://github.com/FelixKratz/JankyBorders)
- [neovim](https://neovim.io) / [lazyvim](https://www.lazyvim.org/) - package manager

## Dotfiles are symlinked on my machine

### Install with stow:

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

### Kill Dock

Follow this command to kill the dock:

```sh
defaults write com.apple.Dock autohide-delay -float 0; killall Dock
```
