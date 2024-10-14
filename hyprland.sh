#!/bin/sh

# Audio
# - pipewire                    => audio/video server
# - pipewire-alsa               => pipewire alsa client
# - pipewire-audio              => pipewire audio client
# - pipewire-jack               => pipewire jack client
# - pipewire-pulse              => pipewire pulseaudio client
# - gst-plugin-pipewire         => pipewire gstreamer client
# - wireplumber                 => pipewire session manager
# - pavucontrol                 => pulseaudio volume control
# - pamixer                     => pulseaudio cli mixer
# - playerctl                   => Media controls
echo -e "\033[0;31mInstalling Audio\033[0m"
yay -Sy --needed --noconfirm pipewire pipewire-alsa pipewire-audio pipewire-jack pipewire-pulse gst-plugin-pipewire wireplumber pavucontrol pamixer playerctl


# Networks
# - networkmanager              => network managment
# - network-manager-applet      => network manager system tray utility
# - bluez                       => bluetooth protocol stack
# - bluez-utils                 => bluetooth utility cli
# - blueman                     => bluetooth manager gui
echo -e "\033[0;31mInstalling Networking\033[0m"
yay -Sy --needed --noconfirm networkmanager network-manager-applet bluez bluez-utils blueman


# Window Manager
# - hyprland                    => The wayland desktop compositer
# - hypridle                    => Idle managment (lock, screen off, suspend)
# - hyprlock                    => Lock screen support
# - cliphist                    => Clipboard manager
# - swaync                      => Notification daemon
# - waybar                      => Add a status bar to hyprland
# - rofi-wayland                => App launcher
# - wlogout                     => Power menu
# - swww                        => Wallpaper manager with animations
# - waypaper                    => Wallpaper selector script utility
echo -e "\033[0;31mInstalling Hyprland\033[0m"
yay -Sy --needed --noconfirm hyprland hypridle hyprlock cliphist swaync waybar rofi-wayland wlogout swww waypaper


# Dependencies
# - qt5-wayland & qt6-wayland   => Add Qt Wayland Support
# - xdg-desktop-portal-hyprland => XDG Desktop Portal
# - polkit-kde-agent            => Authentication Agent
# - libnotify                   => Tool to send notifications
# - power-profiles-daemon       => Ability to change proformance profile
# - imagemagick                 => Manipulate wallpaper images
# - brightnessctl               => screen brightness control
# - udiskie                     => manage removable media
# - jq                          => for json processing
# - gnome-clocks                => Clock manager
# - grimblast-git               => screenshot tool
# - swappy                      => screenshot editor
# - hyprshade                   => Frontend to Hyprland's screen shader
echo -e "\033[0;31mInstalling Dependencies\033[0m"
yay -Sy --needed --noconfirm qt5-wayland qt6-wayland xdg-desktop-portal-hyprland polkit-kde-agent libnotify power-profiles-daemon imagemagick brightnessctl udiskie jq gnome-clocks grimblast-git swappy


# Fonts
# - ttf-jetbrains-mono-nerd     => Nerd Fonts commonly used for icons
# - ttf-liberation              => Arial, Times New Roman ...
# - ttf-dejavu                  => Font family based on the Bitstream Vera Fonts
echo -e "\033[0;31mInstalling Fonts\033[0m"
sudo pacman -Sy --needed --noconfirm ttf-jetbrains-mono-nerd ttf-liberation ttf-dejavu


# Theming
# - sweet-gtk-theme-dark        => Dark theme for gtk
# - obsidian-icon-theme         => Square icons
# - nwg-look                    => gtk configuration tool
# - qt5ct                       => qt5 configuration tool
# - qt6ct                       => qt6 configuration tool
echo -e "\033[0;31mInstalling Theming System\033[0m"
yay -Sy --needed --noconfirm sweet-gtk-theme-dark obsidian-icon-theme nwg-look qt5ct qt6ct


# Display Manager
# - sddm                        => Login manager (Display Manager)
# - qt5-quickcontrols           => for sddm theme ui elements
# - qt5-quickcontrols2          => for sddm theme ui elements
# - qt5-graphicaleffects        => for sddm theme effects
# - sddm-theme-mountain-git     => sddm theme
echo -e "\033[0;31mInstalling Login Manager\033[0m"
yay -Sy --needed --noconfirm sddm qt5-quickcontrols qt5-quickcontrols2 qt5-graphicaleffects
