#!/bin/bash -e

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


# -------------
# Functions
# -------------

# Function to covert a full home path to relative home path
#   $1: The full path of the file
function relative_home() {
    echo "~${1/#$HOME/}"
}


# -------------
# Script
# -------------

# Loop over each and every dotfile in the dotfiles directory
find "$SAVED_DOTFILES_DIR" -type f | while IFS= read -r file; do
    # Convert the dotfile path to a home file path
    home_file="$HOME/${file#$SAVED_DOTFILES_DIR/}"

    # The full path for the backup file
    backup_file="${file/$SAVED_DOTFILES_DIR/$BACKUP_DOTFILES_DIR}"

    # Home file is already a symlink, skiping for safety
    if [ -L "$home_file" ]; then
        echo "Skipping $(relative_home "$home_file") - already a symlink"
        continue
    
    # If the backup file already exists, skip
    elif [ -e "$backup_file" ]; then
        echo "Skipping $(relative_home "$home_file") - already backed up"
        continue
    
    # If the home file exists, backup the file before creating the symlink
    elif [ -e "$home_file" ]; then
        # Ensure the backup directory exists
        mkdir -p "$(dirname "$backup_file")"

        # Move the home file to the backup directory
        echo "Backing up $(relative_home "$home_file")"
        mv $home_file $backup_file
    fi

    # Create the symlink
    echo "Creating symlink for $(relative_home "$home_file")"
    ln -s $file $home_file
done
