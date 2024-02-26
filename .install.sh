#!/bin/zsh

# Install xCode cli tools
echo "Installing commandline tools..."
xcode-select --install

# Homebrew
## Install
echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew analytics off

## Taps
echo "Tapping Brew..."
brew tap homebrew/cask-fonts
brew tap FelixKratz/formulae
brew tap koekeishiya/formulae

# Casks
echo "Installing Brew Casks..."
brew install --cask alt-tab
brew install --cask appcleaner
brew install --cask espanso
brew install --cask firefox
brew install --cask font-hack-nerd-font
brew install --cask font-symbols-only-nerd-font
brew install --cask font-ubuntu-mono-nerd-font
brew install --cask hazel
brew install --cask iina
brew install --cask keka
brew install --cask latest
brew install --cask lulu
brew install --cask middleclick
brew install --cask obsidian
brew install --cask raycast
brew install --cask sf-symbols
brew install --cask spotify
brew install --cask wezterm

# Fresh installation
# Ensure that the leaves txt file is in the same directory
xargs brew install < leaves.txt
