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
brew tap espanso/espanso

sleep 10

# Casks
echo "Installing Brew Casks..."
brew install --cask 1password
brew install --cask alt-tab
brew install --cask appcleaner
brew install --cask cleanshot
brew install --cask drawio
brew install --cask espanso
brew install --cask ghostty
brew install --cask freetube
brew install --cask iina
brew install --cask keka
brew install --cask knockknock
brew install --cask karabiner-elements
brew install --cask latest
brew install --cask little-snitch
brew install --cask melonds
brew install --cask middleclick
brew install --cask mimestream
brew install --cask maccy
brew install --cask notion
brew install --cask obsidian
brew install --cask pearcleaner
brew install --cask protonvpn
brew install --cask pictogram
brew install --cask raycast
brew install --cask sf-symbols
brew install --cask spotify
brew install --cask wezterm
brew install --cask zen-browser

# Extras
brew install tailscale
brew install wireshark
brew install git

# Install repository
# mkdir .dotfiles
# cd .dotfiles
# git clone https://github.com/moonlinx/dotfiles.git 

# cd ~

# sleep 5

# Find these other apps
echo "Please find and install the following apps from the following links
https://stacher.io/
https://github.com/Vencord/Vesktop?tab=readme-ov-file

# Give time to copy all of the links
sleep 10

# macOS Settings
echo "Changing macOS defaults..."
defaults write com.apple.dock "orientation" -string "bottom" 
defaults write com.apple.dock "tilesize" -int "30" 
defaults write com.apple.dock "autohide" -bool "true" 
defaults write com.apple.dock "autohide-time-modifier" -float "0" 
defaults write com.apple.dock "autohide-delay" -float "0" 
defaults write com.apple.dock "show-recents" -bool "false" 
defaults write com.apple.dock "mineffect" -string "scale"
defaults write com.apple.dock "scroll-to-open" -bool "true"
defaults write com.apple.screencapture "disable-shadow" -bool "true"
defaults write com.apple.finder "QuitMenuItem" -bool "true"
defaults write com.apple.finder "DisableAllAnimations" -bool true
defaults write com.apple.finder "ShowExternalHardDrivesOnDesktop" -bool false
defaults write com.apple.finder "ShowHardDrivesOnDesktop" -bool false
defaults write com.apple.finder "ShowMountedServersOnDesktop" -bool false
defaults write com.apple.finder "ShowRemovableMediaOnDesktop" -bool false
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"
defaults write com.apple.finder "ShowPathbar" -bool "true"
defaults write com.apple.finder "FXPreferredViewStyle" -string "Nlsv"
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true"
defaults write com.apple.finder "FXDefaultSearchScope" -string "SCev"
defaults write com.apple.finder "FXRemoveOldTrashItems" -bool "true"
defaults write com.apple.finder "FXEnableExtensionChangeWarning" -bool "true"
defaults write com.apple.universalaccess "showWindowTitlebarIcons" -bool "true"
defaults write NSGlobalDomain "NSTableViewDefaultSizeMode" -int "1"
defaults write com.apple.finder "CreateDesktop" -bool "false" && killall Finder
defaults write com.apple.menuextra.clock "FlashDateSeparators" -bool "true" && killall SystemUIServer
defaults write com.apple.menuextra.clock "DateFormat" -string "\"EEE d MMM HH:mm:ss\""
defaults write NSGlobalDomain com.apple.mouse.scaling -float "3.0"
defaults write com.apple.AppleMultitouchTrackpad "FirstClickThreshold" -int "0"
defaults write com.apple.AppleMultitouchTrackpad "DragLock" -bool "false"
defaults write com.apple.AppleMultitouchTrackpad "Dragging" -bool "false"
defaults write com.apple.AppleMultitouchTrackpad "TrackpadThreeFingerDrag" -bool "true"
defaults write com.apple.dock "mru-spaces" -bool "false"
defaults write com.apple.dock "expose-group-apps" -bool "false" && killall Dock


# Start Services
echo "Starting Services (grant permissions)..."
yabai --start-service
skhd --start-service
brew services start sketchybar
brew services start borders

csrutil status
echo "(optional) Disable SIP for advanced yabai features."

sleep 3

# Fresh installation
# Ensure that the leaves txt file is in the same directory
echo "Please head to the Homebrew folder to install the leaves."


echo "Installation complete...\n"
