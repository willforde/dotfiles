#!/bin/sh

# CLI Tools
# - flatpak     => Install flatpak applications
sudo pacman -Sy --needed --noconfirm flatpak

# Application
# - firefox         => Firefox browser and language support
# - kitty           => Terminal emulator
# - nautilus        => File manager
# - file-roller     => Create and modify archives
# - eog             => Image viewer
# - code            => IDE text editor
# - 1password       => Password Manager
# - zen-browser-bin => The zen browser, based on firefox
sudo pacman -Sy --needed --noconfirm firefox firefox-i18n-en-gb hunspell-en_gb kitty nautilus file-roller eog code
yay -Sy --needed --noconfirm 1password zen-browser-bin

# Dependencies
# - ffmpegthumbnailer   => Lightweight video thumbnailer that can be used by file managers
# - gst-libav           => Multimedia graph framework for thumbnailer
# - gst-plugins-ugly    => Multimedia graph framework for thumbnailer
sudo pacman -Sy --needed --noconfirm ffmpegthumbnailer gst-libav gst-plugins-ugly
