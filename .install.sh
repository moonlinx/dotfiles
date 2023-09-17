#!/bin/zsh

# Install Code cli tools
echo "Installing commandline tools..."
xcode-select --install

# Install Brew
echo "Installing HomeBrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew analytics off

#
