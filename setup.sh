#!/bin/bash

set -e

DOTFILES_DIR="$HOME/dotfiles/nix"
HOME_MANAGER_CONFIG="$HOME/.config/home-manager"

# 1. Check if Nix is installed
if ! command -v nix >/dev/null 2>&1; then
    echo "Nix is not installed. Installing Nix..."
    # Install Nix (multi-user mode by default)
    curl -L https://nixos.org/nix/install | sh
else
    echo "Nix is already installed."
fi

# 2. Create symbolic links to Home Manager files
echo "Creating symbolic links for Home Manager configuration..."

# Ensure the target directory exists
mkdir -p "$HOME_MANAGER_CONFIG"

# Files to link
FILES=("flake.nix" "flake.lock" "home.nix")

# Iterate over files and create symlinks
for FILE in "${FILES[@]}"; do
    SRC="$DOTFILES_DIR/$FILE"
    DEST="$HOME_MANAGER_CONFIG/$FILE"
    
    if [ -L "$DEST" ] || [ -e "$DEST" ]; then
        echo "File $DEST already exists. Skipping..."
    else
        echo "Linking $SRC -> $DEST"
        ln -s "$SRC" "$DEST"
    fi
done

# Link nix.conf file to .config/nix/nix.conf
NIX_CONFIG="$HOME/.config/nix/nix.conf"

if [ ! -e "$NIX_CONFIG" ]; then
    mkdir -p "$HOME/.config/nix"
    ln -s "$HOME/dotfiles/nix/nix.conf" "$NIX_CONFIG"
fi

# 3. Set up Home Manager
echo "Setting up Home Manager..."
nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install


# 4. Switch to the Home Manager profile
echo "Switching to Home Manager profile..."
home-manager switch

echo "Setup complete!"

