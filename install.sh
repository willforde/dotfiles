#!/bin/bash
set -e

# This script creates symlinks from the home directory to any desired dotfiles in the dotfiles directory.
# If a destination dotfile already exists, it will be moved to the backup directory before creating the symlink.
# But if a destination dotfile already exists in the backup directory, it will be skipped.


# -------------
# Variables
# -------------

PROJECT_ROOT=$(dirname "$0")
PROJECT_ROOT=$(realpath "$PROJECT_ROOT")
BACKUP_DOTFILES_DIR="$PROJECT_ROOT/backups"
SAVED_DOTFILES_DIR="$PROJECT_ROOT/dotfiles"

# Get the operating system
source /etc/os-release
DISTRO="$NAME"


# -------------
# Script
# -------------

# Install required system packages for Arch Linux
if [ "$DISTRO" = "Arch Linux" ]; then
    echo "Installing required system packages for Arch Linux..."

    # Install packages for the ~/.zshrc file
    # - git - show git repository status
    # - zsh - the shell itself
    # - zsh-syntax-highlighting - Fish shell like syntax highlighting for Zsh
    # - zsh-autosuggestions - Fish-like autosuggestions for zsh
    # - zsh-completions - Additional completion definitions for Zsh
    sudo pacman -Sy --needed --noconfirm git zsh zsh-syntax-highlighting zsh-autosuggestions zsh-completions

    # Install packages for the ~/.zshrc from the AUR
    # - oh-my-zsh-git - managed zsh config
    # - chroma - add syntax highlighting to files
    # - archey4 - nice display of system info on terminal start
    # - 1password - Password manager and secure wallet
    # - nano-syntax-highlighting-git - Syntax highlighting for nano (git version fixes issue from repo)
    if ! command -v yay &> /dev/null; then
        echo "Yay not installed. Installing..."
        current_dir="$(pwd)"

        # Download and extract yay
        curl -SL -o /tmp/yay.tar.gz https://aur.archlinux.org/cgit/aur.git/snapshot/yay.tar.gz
        tar -zxvf /tmp/yay.tar.gz -C /tmp
        rm /tmp/yay.tar.gz
        cd /tmp/yay

        # Build and install yay
        makepkg --syncdeps --noconfirm --install
        cd $current_dir
        rm -rf /tmp/yay
    fi

    # Install packages from the AUR
    yay -Sy --needed --noconfirm oh-my-zsh-git chroma archey4 1password nano-syntax-highlighting-git
fi

# Loop over each and every dotfile in the dotfiles directory
echo "Creating symlinks for dotfiles..."
find "$SAVED_DOTFILES_DIR" -type f | while IFS= read -r file; do
    # Convert the dotfile path to a home file path
    home_file="$HOME/${file#$SAVED_DOTFILES_DIR/}"
    relative_home_file="~${home_file/#$HOME/}"

    # The full path for the backup file
    backup_file="${file/$SAVED_DOTFILES_DIR/$BACKUP_DOTFILES_DIR}"

    # Home file is already a symlink, skiping for safety
    if [ -L "$home_file" ]; then
        echo "Skipping $relative_home_file - already a symlink"
        continue
    
    # If the backup file already exists, skip
    elif [ -e "$backup_file" ]; then
        echo "Skipping $relative_home_file - already backed up"
        continue
    
    # If the home file exists, backup the file before creating the symlink
    elif [ -e "$home_file" ]; then
        # Ensure the backup directory exists
        mkdir -p "$(dirname "$backup_file")"

        # Move the home file to the backup directory
        echo "Backing up $relative_home_file"
        mv $home_file $backup_file
    fi

    # Create the symlink
    echo "Creating symlink for $relative_home_file"
    mkdir -p "$(dirname "$home_file")"
    ln -s $file $home_file
done

# Ensure the default shell is /bin/zsh
if [ "$SHELL" != "/bin/zsh" ]; then
    echo "Your current default shell is $default_shell. Changing it to /bin/zsh..."
    chsh -s /bin/zsh
fi
