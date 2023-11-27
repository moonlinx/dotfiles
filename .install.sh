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
brew install autoconf
brew install bat
brew install curl
brew instal exa
brew install fd
brew install fzf
brew install gd
brew install git
brew install imath
brew install nano
brew install neofetch
brew install neovim
brew install openssh
brew install php
brew install python@3.12
brew install rust
brew install six
brew install spotify-tui
brew install tree
brew install zsh
brew install zoxide
brew install sketchybar
brew install skhd
brew install yabai 
brew install ifstat
brew install screenresolution
brew install switchaudio-osx
brew install ripgrep

### Casks
brew install --cask alt-tab
brew install --cask appcleaner
brew install --cask espanso
brew install --cask firefox
brew install --cask hazel
brew install --cask iina
brew install --cask iterm2
brew install --cask keka
brew install --cask orion
brew install --cask raycast
brew install --cask sf-symbols
brew install --cask spotify
brew install --cask vscodium


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

### Firefox setup
cd ~/Downloads/


