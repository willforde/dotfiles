#!/bin/bash
set -eu


# Ensure yay is installed
function install_yay() {
    # Install Yay AUR helper if not already installed
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
        sudo rm -rf /tmp/yay
    else
        echo "Yay already installed. Skipping..."
    fi
}


# Install required packages
function install_arch_requirements() {
    echo "Installing required system packages for Arch Linux..."
    # Install packages for the ~/.zshrc file
    # - git - show git repository status
    # - zsh - the shell itself
    # - zsh-syntax-highlighting - Fish shell like syntax highlighting for Zsh
    # - zsh-autosuggestions - Fish-like autosuggestions for zsh
    # - zsh-completions - Additional completion definitions for Zsh
    # - lm_sensors - for battery status and temperature in fastfetch
    # - fastfetch - CLI system information tool
    # - nano - CLI text editor
    sudo pacman -Sy --needed --noconfirm zsh zsh-syntax-highlighting zsh-autosuggestions zsh-completions
    sudo pacman -Sy --needed --noconfirm git lm_sensors fastfetch nano 
    install_yay

    # Install packages from the AUR
    # - oh-my-zsh-git - managed zsh config
    # - nano-syntax-highlighting-git - Syntax highlighting for nano (git version fixes issue from repo)
    yay -Sy --needed --noconfirm oh-my-zsh-git nano-syntax-highlighting-git

    # Detect and configure sensors
    sudo sensors-detect --auto
}


# Improve pacman output
function colorize_pacman() {
    # Enable color option
    sudo sed -i 's/^#Color/Color/' /etc/pacman.conf
    # Show full package list
    sudo sed -i 's/^#VerbosePkgLists/VerbosePkgLists/' /etc/pacman.conf
}


# Install useful arch packages
function install_arch_goodies() {
    echo "Installing useful Arch Linux packages"
    # locate - Fast command line file search tool
    # pacman-contrib - Contributed scripts and tools for pacman
    # wget - CLI network utility to retrieve files from the web
    sudo pacman -Sy --needed --noconfirm pacman-contrib locate openssh wget
    support_virtual_machines
    setup_reflector

    # Enable ssh
    sudo systemctl enable sshd.service

    # Enable SSD periodic trim
    sudo systemctl enable fstrim.timer
    
    # Clean the package cache once a week
    sudo systemctl enable paccache.timer
    
    # Force create package database, fix "command not found" script
    sudo pacman -Fy

    # Build locate database
    sudo updatedb
}

# Install virtual machine requirements
function support_virtual_machines() {
    case "$(systemd-detect-virt)" in
        "vmware")
            sudo pacman -Sy --needed --noconfirm open-vm-tools
            sudo systemctl enable --now vmtoolsd.service
            ;;
        "oracle")
            sudo pacman -Sy --needed --noconfirm virtualbox-guest-utils
            sudo systemctl enable --now vboxservice.service
            ;;
        "qemu")
            sudo pacman -Sy --needed --noconfirm qemu-guest-agent
            sudo systemctl enable --now qemu-guest-agent.service
            ;;
    esac
}

# Install and configure reflector
function setup_reflector() {
    # reflector - Sort pacman mirrors by up-to-date and speed
    sudo pacman -Sy --needed --noconfirm reflector

    # Restrict mirrors to the UK
    sudo sed -i '$ a --country GB' /etc/xdg/reflector/reflector.conf

    # Prevent pacman from changing mirrorlist
    sudo sed -i 's/^#NoExtract   =/NoUpgrade = \/etc\/pacman.d\/mirrorlist/' /etc/pacman.conf

    # Enable reflector service
    sudo systemctl enable reflector.timer
    sudo systemctl start reflector.service
}

# Setup GPU
function setup_gpu() {
    # Install the correct Vulkan driver for the GPU
    gpu_driver=$(lspci -k | grep -A 2 -E "VGA|3D|Display" | grep "Kernel driver in use" | sed 's/.*Kernel driver in use: //')
    case $gpu_driver in
        "nvidia")
            sudo pacman -S --noconfirm --needed --asdeps nvidia-utils lib32-nvidia-utils
            ;;
        "amdgpu")
            sudo pacman -S --noconfirm --needed --asdeps vulkan-radeon lib32-vulkan-radeon
            ;;
        "i915")
            sudo pacman -S --noconfirm --needed --asdeps vulkan-intel lib32-vulkan-intel
            ;;
    esac
}
