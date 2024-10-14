#!/bin/sh

# Application
# - firefox     => Firefox browser and language support
# - kitty       => Terminal emulator
# - nautilus    => File manager
# - file-roller => Create and modify archives
# - eog         => Image viewer
# - code        => IDE text editor
# - 1password   => Password Manager
sudo pacman -Sy --needed --noconfirm firefox firefox-i18n-en-gb hunspell-en_gb kitty nautilus file-roller eog code
yay -Sy --needed --noconfirm 1password

# Alternate browser
# zen-browser-bin => The zen browser, based on firefox
# yay -S zen-browser-bin

# Alternate file manager
# - dolphin             => kde file manager
# - qt5-imageformats    => for dolphin image thumbnails
# - ffmpegthumbs        => for dolphin video thumbnails
# - kde-cli-tools       => for dolphin file type defaults
# - ark                 => kde file archiver
# sudo pacman -S dolphin qt5-imageformats ffmpegthumbs kde-cli-tools ark
