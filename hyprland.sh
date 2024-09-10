#!/bin/sh

# Install core requirements
# - hyprland => The desktop compositer
# - hyprlock => Lock screen support
# - hypridle => Idle managment (lock, screen off, suspend)
# - xdg-desktop-portal-hyprland => XDG Desktop Portal
# - polkit-kde-agent => Authentication Agent
# - pipewire & wireplumber => Full system audio support
# - qt5-wayland & qt6-wayland => Add Qt Wayland Support
# - swaync => Notification daemon
# - waybar => Add a status bar to hyprland
# - power-profiles-daemon => Ability to change proformance profile
# - brightnessctl => Read and control device brightness
# - cliphist => Clipboard manager
# - rofi-wayland => App launcher
# - wlogout => Power menu
# - sddm => Login manager (Display Manager)
# - swww => Wallpaper manager with animations
# - imagemagick => Manipulate wallpaper images
# - waypaper => Wallpaper selector
# - libnotify => Tool to interact with notification center
sudo pacman -Sy hyprland hyprlock hypridle xdg-desktop-portal-hyprland polkit-kde-agent pipewire wireplumber qt5-wayland qt6-wayland swaync waybar power-profiles-daemon brightnessctl cliphist rofi-wayland sddm swww imagemagick libnotify
yay -Sy wlogout waypaper


# Fonts
# - ttf-jetbrains-mono-nerd => Fonts for waybar to be able to display nice icons
sudo pacman -Sy ttf-jetbrains-mono-nerd


# Theming
# sweet-gtk-theme-dark => Light and dark colorful Gtk3.20+ theme
yay -Sy sweet-gtk-theme-dark sddm-theme-mountain-git




# Optional
# - dolphin => File manager
sudo pacman -S dolphin swaync layer-shell-qt
# neofetch
