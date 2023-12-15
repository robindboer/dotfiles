#!/bin/bash

# Check if Homebrew is already installed
if ! command -v brew &>/dev/null; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed."
fi

# Configure the dock 
defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock mineffect -string "scale"

# Reset the Dock to apply changes
killall Dock

apps=(
    "1password"
    "pyenv"
    "rectangle"
    "alacritty"
    "tmux"
    "neovim"
)

for app in "${apps[@]}"
do
    echo "Installing $app..."
    brew install "$app"
done

echo "All applications installed."

