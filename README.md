# Dotfiles

This repository contains my personal dotfiles, which are used to configure my development environment on Arch Linux & MacOS.

Instead of having just a collection of dotfiles, I created a install script that installs the dotfiles, along with any dependencies that are required. The dotfiles are stored in the data directory and are broken down by environment.

The script is setup to be able to install and configure the following desktop environments, if required. 
* Gnome
* Hyprland (WIP)
* MacOS (WIP)


## Prerequisites

### Arch Linux
For Arch Linux, there are a few requirements that are needed for the script to work fully.
* The multilib optional repositorie is required.
* User needs sudo permissions.
* Git needs to be installed.

Some other recommendations for Arch Linux, Optional.
* Btrfs is preferred for the filesystem.
* Use of pipewire for audio is preferred.
* Network Manager is a good option for both Hyprland and Gnome.

### MacOS
Work in progress.


## Installation

To use these dotfiles, simply clone this repository to the home directory and run the installation script. 

```bash
cd ~
git clone https://github.com/willforde/dotfiles.git .dotfiles
cd .dotfiles
bash install.bash
```

This will symlink the dotfiles in the `data` directory to the home directory. Any existing dotfiles in the home directory will be backed up to a backup folder within this repo.

If running on Arch Linux, it will ask if you would like to install any of the supported environments and if you would like to install the predefined list of applications.
