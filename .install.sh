#!/bin/zsh

# Install Code cli tools
echo "Installing commandline tools..."
xcode-select --install

# Install Brew
echo "Installing HomeBrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew analytics off

# Install iterm2
echo "Installing iterm2..."
brew install --cask iterm2

# Taps
echo "Tapping Brew..."
brew tap homebrew/cask-fonts
brew tap FelixKratz/formulae
brew tap koekeishiya/formulae

# Install brew Formulae
echo "Installing Brew Formulae..."
### Essentials
brew install sketchybar
brew install skhd
brew install yabai 
brew install ifstat
brew install switchaudio-osx
brew install ripgrep

### Terminal
brew install neovim
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting

### Nice to have
brew install --cask lulu
brew install htop
brew install btop

### Fonts
brew install --cask sf-symbols
brew install --cask font-hack-nerd-font
brew install --cask font-jetbrains-mono
brew install --cask font-fira-code
