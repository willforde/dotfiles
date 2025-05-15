#!/bin/sh
set -eu


# Install applications
function install_general_apps() {
    echo "Installing applications"
    # - filezilla           => Fast and reliable FTP, FTPS and SFTP client
    # - deluge              => BitTorrent client with multiple user interfaces in a client/server model
    # - mpv                 => a free, open source, and cross-platform media player
    # - remmina             => Remote desktop client written in GTK+
    # - variety             => Changes the wallpaper on a regular interval using user-specified or automatically downloaded images.
    # - jdownloader2        => Download manager for one-click hosting sites
    # - 1password           => Password Manager
    # - jellyfin-mpv-shim   => Cast media from Jellyfin Mobile and Web apps to MPV
    # - input-leap          => Open-source KVM software
    # - uxplay              => AirPlay Unix mirroring server
    sudo pacman -Sy --needed --noconfirm filezilla deluge mpv remmina variety jellyfin-mpv-shim input-leap
    yay -Sy --needed --noconfirm jdownloader2 1password uxplay
}


# Install dev applications
function install_dev_apps() {
    echo "Installing dev applications"
    # - code                        => OSS version of Visual Studio Code
    # - pycharm-community-edition   => Python IDE for Professional Developers
    sudo pacman -Sy --needed --noconfirm pycharm-community-edition code
}


# Install browsers
function install_browsers() {
    echo "Install most common browsers"
    # - firefox - Fast, Private & Safe Web Browser
    # - chromium - A web browser built for speed, simplicity, and security
    # - zen-browser-bin - The zen browser, based on firefox
    # - hunspell - Spell checker and morphological analyzer library and program
    # - profile-cleaner - Simple script to vacuum and reindex sqlite databases used by browsers
    sudo pacman -Sy --needed --noconfirm firefox firefox-i18n-en-gb chromium hunspell hunspell-en_gb profile-cleaner
    yay -Sy --needed --noconfirm zen-browser-bin
}


# Install Gparted
function install_gparted() {
    echo "Installing gparted and it's dependencies"
    # Install Gparted disk managment tool
    # - btrfs-progs - for btrfs partitions
    # - dosfstools - for FAT16 and FAT32 partitions
    # - exfatprogs - for exFAT partitions
    # - f2fs-tools - for Flash-Friendly File System
    # - gpart - for recovering corrupt partition tables
    # - jfsutils - for jfs partitions
    # - mtools - utilities to access MS-DOS disks
    # - nilfs-utils - for nilfs2 support
    # - ntfs-3g - for ntfs partitions
    # - polkit - to run gparted from application menu
    # - udftools - for UDF file system support
    # - xfsprogs - for xfs partitions
    # - xorg-xhost - authorization from wayland
    sudo pacman -Sy --needed --noconfirm gparted
    sudo pacman -Sy --needed --noconfirm --asdeps btrfs-progs dosfstools exfatprogs f2fs-tools gpart jfsutils mtools nilfs-utils ntfs-3g polkit udftools xfsprogs xorg-xhost
}


# Install Steam and other games apps
function install_game_apps() {
    # Generated en_US.UTF-8 locale, preventing invalid pointer error
    sudo sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
    sudo locale-gen

    # Increase vm.max_map_count for better performance with old games
    echo "vm.max_map_count = 2147483642" | sudo tee /etc/sysctl.d/80-gamecompatibility.conf
    sudo sysctl --system

    # Install Steam
    sudo pacman -S --noconfirm --needed --asdeps ttf-liberation
    sudo pacman -S --noconfirm --needed steam
    yay -S --noconfirm --needed heroic-games-launcher
}

# Install Office apps
function install_office_apps() {
    # Install WPS Office
    yay -S --noconfirm --needed --asdeps ttf-wps-fonts
    yay -S --noconfirm --needed wps-office
}

# Copy over static files
function copy_staticfiles() {
    local staticfiles_dir=$1

    # Variety
    mkdir -p ~/.config/variety/
    if [ ! -e "$staticfiles_dir/variety.conf" ]; then
        cp "$staticfiles_dir/variety.conf" ~/.config/variety/variety.conf
    fi

    # MPV Shim
    mkdir -p ~/.config/jellyfin-mpv-shim
    if [ ! -e "$staticfiles_dir/jellyfin-mpv-shim.json" ]; then
        cp "$staticfiles_dir/jellyfin-mpv-shim.json" ~/.config/jellyfin-mpv-shim/conf.json
    fi
}
