#!/bin/sh
set -eu


# Install Gnome Desktop
function install_gnome() {
    echo "Installing base Gnome packages..."
    # Install the gnome group excluding some unwanted packages:
    # - epiphany          - A GNOME web browser based on the WebKit rendering engine
    # - gnome-connections - Remote desktop client for the GNOME desktop environment
    # - gnome-maps        - Find places around the world
    # - gnome-menus       - GNOME menu specifications
    # - gnome-music       - Music player and management application
    # - gnome-text-editor - A simple text editor for the GNOME desktop
    # - gnome-tour        - Guided tour and greeter for GNOME
    # - gnome-console     - A simple terminal emulator
    # - malcontent        - Parental control support for applications
    # - orca              - Screen reader for individuals who are blind or visually impaired
    # - simple-scan       - Simple scanning utility
    # - totem             - Movie player for the GNOME desktop based on GStreamer
    # - yelp              - Get help with GNOME
    # - gnome-user-docs   - User documentation for GNOME
    # - snapshot          - Take pictures and videos (camera app)
    pacman -Sgq gnome | grep -v -E 'epiphany|gnome-connections|gnome-maps|gnome-menus|gnome-music|gnome-text-editor|gnome-tour|gnome-console|malcontent|orca|simple-scan|totem|yelp|gnome-user-docs|snapshot' | sudo pacman -Sy --needed --noconfirm -
    sudo systemctl enable gdm
    
    echo "Installing extra Gnome packages..."
    # - gnome-tweaks    - Graphical interface for advanced GNOME 3 settings
    # - iwd             - Internet Wireless Daemon
    # - wireless_tools  - Tools allowing to manipulate the Wireless Extensions
    # - dconf-editor    - GSettings editor for GNOME
    # - gnome-terminal  - The GNOME Terminal Emulator
    # - file-roller     - Create and modify archives
    # - flatpak         - Install flatpak applications
    # - numix-square-icon-theme-git - Square numix icons
    # - gnome-themes-extra          - Extra Themes for GNOME Applications
    sudo pacman -Sy --needed --noconfirm gnome-tweaks iwd wireless_tools file-roller dconf-editor gnome-terminal flatpak gnome-themes-extra
    yay -Sy --needed --noconfirm numix-square-icon-theme-git
    
    # Dependencies
    echo "Installing Gnome optional dependencies..."
    # - ffmpegthumbnailer   - Lightweight video thumbnailer that can be used by file managers
    # - gst-libav           - Multimedia graph framework for thumbnailer
    # - gst-plugins-ugly    - Multimedia graph framework for thumbnailer
    # - 7zip                - File archiver for extremely high compression
    # - unrar               - The RAR uncompression program
    # - unzip               - For extracting and viewing files in .zip archives
    sudo pacman -Sy --needed --noconfirm ffmpegthumbnailer gst-libav gst-plugins-ugly
    sudo pacman -Sy --needed --noconfirm --asdeps 7zip unrar unzip
}


# Install & configure Extentions
function install_extentions() {
    # Install extentions
    sudo pacman -Sy --needed --noconfirm gnome-shell-extension-appindicator
    
    # Enable extensions
    dbus-launch gsettings set org.gnome.shell enabled-extensions "['user-theme@gnome-shell-extensions.gcampax.github.com', 'appindicatorsupport@rgcjonas.gmail.com']"
}


# Configure Gnome Desktop
function configure_gnome() {
    # Enable dark mode
    dbus-launch gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
    # Show weekday on clock
    dbus-launch gsettings set org.gnome.desktop.interface clock-show-weekday true
    # Set GTK & icon themes
    dbus-launch gsettings set org.gnome.desktop.interface icon-theme "Numix-Square"
    dbus-launch gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
    # Minimize window on middle clock on window
    dbus-launch gsettings set org.gnome.desktop.wm.preferences action-middle-click-titlebar "minimize"

    # Enable Night Light
    dbus-launch gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true

    # Disable automatic screen blank power option when running inside a VM
    if [ "$(systemd-detect-virt)" != "none" ]; then
        dbus-launch gsettings set org.gnome.desktop.session idle-delay 0
    fi

    # Change some gnome terminal settings
    profile=$(dbus-launch gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
    dbus-launch gsettings set "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/" scrollbar-policy "never"
    dbus-launch gsettings set "org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$profile/" bold-is-bright true
}
