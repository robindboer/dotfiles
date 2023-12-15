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
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Reset the Dock to apply changes
killall Dock

# Oh my zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My Zsh is already installed."
fi

# Pure prompt
if [ ! -d "$HOME/.zsh/pure" ]; then
    echo "Installing Pure Prompt..."
    mkdir -p "$HOME/.zsh"
    git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
else
    echo "Pure Prompt is already installed."
fi

# Completions
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-completions" ]; then
    echo "Installing zsh-completions..."
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-completions
else
    echo "zsh-completions is already installed."
fi

# Install Syntax Highlighting
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
    echo "Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
else
    echo "zsh-syntax-highlighting is already installed."
fi

source $HOME/.zshrc

apps=(
    "1password"
	"1password-cli"
    "pyenv"
    "rectangle"
    "alacritty"
    "tmux"
    "neovim"
    "google-chrome"
    "rustup"
	"jq"
	"gpg"
	"ripgrep"
	"slack"
	"docker"
	"docker-compose"
	"spotify"
	"whatsapp"
)

for app in "${apps[@]}"
do
    echo "Installing $app..."
    brew install "$app"
done

echo "All applications installed."

# Install JetBrains Mono Nerd Font
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font


# Import GPG Key
VAULT_NAME="Personal"
GPG_KEY_ITEM_NAME="GPG Private Key"
GPG_KEY_IDENTIFIER="7327FD2A4FE000523D74CCFAC48F83D239E5C846"

if gpg --list-secret-keys | grep -q "$GPG_KEY_IDENTIFIER"; then
    echo "GPG key ($GPG_KEY_IDENTIFIER) is already imported."
else
	local gpg_key_document_id=$(op document list --vault="$VAULT_NAME" | grep "$GPG_KEY_ITEM_NAME" | awk '{print $1}')

	if [ -z "$gpg_key_document_id" ]; then
		echo "Error: Document not found."
		return 1
	fi

	op documents get $gpg_key_document_id --out-file private.gpg
	gpg --import private.gpg
	rm private.gpg
fi

# Import SSH keys
ssh_keys=("id_rsa" "id_ecdsa")
for key_name in "${ssh_keys[@]}"; do
	if [ -f "$HOME/.ssh/$key_name" ]; then
		continue
	fi

    while IFS=' ' read -r document_uuid filename; do
        if [ -z "$document_uuid" ] || [ -z "$filename" ]; then
            echo "Error: Document $key_name not found."
            continue
        fi

        op documents get "$document_uuid" --out-file "$HOME/.ssh/$filename"
        chmod 600 "$HOME/.ssh/$filename"
        echo "Document saved as $HOME/.ssh/$filename."

    done < <(op document list --vault="$VAULT_NAME" | grep "$key_name" | awk '{print $1, $2}')
done

# Check if rustup-init has been run (Rust is installed)
if [ -d "$HOME/.rustup" ] || command -v rustup &> /dev/null; then
    echo "rustup is already installed."
else
	rustup-init
fi


# Setup dev dir
DEV_DIR="$HOME/dev"
if [ ! -d "$DEV_DIR" ]; then
    # Create the directory
    mkdir "$DEV_DIR"
    echo "Directory created: $DEV_DIR"
fi
