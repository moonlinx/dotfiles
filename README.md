# .dotfiles

Personal MacOS dotfile congigurations.
![sketchybar@2x](https://github.com/moonlinx/dotfiles/assets/49962728/8bc75917-8bad-492d-936c-dbf840256a6f)

This config tree:
https://github.com/moonlinx/dotfiles/tree/8beae42ea12945ba884f9ec6217f61ef886deb12

Normal navigation with vim navigation customized for terminal applications.

### Installs

- [Sketchybar](https://github.com/FelixKratz/SketchyBar)
- [yabai](https://github.com/koekeishiya/yabai)
- [skhd](https://github.com/koekeishiya/skhd)
  [JankyBorders](https://github.com/FelixKratz/JankyBorders)
- [neovim](https://neovim.io) / [lazyvim](https://www.lazyvim.org/) - nvim package manager

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
