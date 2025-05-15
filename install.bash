#!/bin/bash
set -eu

# This script creates symlinks from the home directory to any desired dotfiles in the dotfiles directory.
# If a destination dotfile already exists, it will be moved to the backup directory before creating the symlink.
# But if a destination dotfile already exists in the backup directory, it will be skipped.


# -------------
# Variables
# -------------

PROJECT_ROOT=$(realpath "$(dirname "$0")")
BACKUP_DIR="$PROJECT_ROOT/backups"
SCRIPTS_DIR="$PROJECT_ROOT/scripts"
DOTFILES_DIR="$PROJECT_ROOT/data"
STATICFILES_DIR="$PROJECT_ROOT/data/staticfiles"

# Get the operating system
source /etc/os-release
DISTRO="$NAME"

# Load in functions
source "$SCRIPTS_DIR/functions.bash"


# ------
# Script
# ------

# Install required system packages for Arch Linux
if [ "$DISTRO" = "Arch Linux" ]; then
    # Ask if user would like to setup a desktop env
    options=("1|Gnome" "2|Hyprland")
    show_option_menu "Choose a desktop environment to install" options
    if ask_for_applications; then
        # Response is cached for later
        ask_for_games || true
        ask_for_office || true
    fi
    system=$RET

    # Setup Arch Linux env
    source "$SCRIPTS_DIR/archlinux.bash"
    colorize_pacman
    install_arch_requirements
    install_arch_goodies
    setup_gpu

    # Install Arch Linux specific dotfiles
    populateDotfiles "$DOTFILES_DIR/archlinux"

    # Install and setup System OS
    case $system in
        "Gnome")
            echo "Installing Gnome with dotfiles..."
            source "$SCRIPTS_DIR/gnome.bash"
            install_gnome
            install_extentions
            configure_gnome
            populateDotfiles "$DOTFILES_DIR/gnome"
            ;;
        "Hyprland")
            echo "Installing Hyprland with dotfiles..."
            source "$SCRIPTS_DIR/hyprland.bash"
            populateDotfiles "$DOTFILES_DIR/hyprland"
            ;;
    esac

    # Install desktop apps is requested
    if ask_for_applications; then
        source "$SCRIPTS_DIR/archapps.bash"
        install_general_apps
        install_dev_apps
        install_browsers
        install_gparted
        copy_staticfiles "$STATICFILES_DIR"

        # Install Steam if requested
        if ask_for_games; then
            install_game_apps
        fi

        # Install office apps
        if ask_for_office; then
            install_office_apps
        fi

        # Install app spcific dotfiles
        populateDotfiles "$DOTFILES_DIR/archapps"
    fi

elif [ "$DISTRO" = "MacOS" ]; then
    # Setup MacOS env
    source "$SCRIPTS_DIR/macos.bash"
    install_macos_requirements

    # Install MacOS specific dotfiles
    populateDotfiles "$DOTFILES_DIR/macos"
else
    echo "Only Arch Linux & MacOS is supported."
    exit 1
fi

# Setup base dotfiles
echo "Installing common dotfiles"
populateDotfiles "$DOTFILES_DIR/common"

# Ensure the default shell is ZSH
if [ "$SHELL" != "/bin/zsh" ]; then
    echo "Your current default shell is $SHELL. Changing it to /bin/zsh..."
    chsh -s /bin/zsh
fi

echo
echo "#############################################"
echo You can now restart the system when your ready
