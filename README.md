# Dotfiles

This repository contains my personal dotfiles, which are used to configure my development environment on Linux.

It is build to support Arch linux. MacOS support coming soon. Folder structure may need to change to support MacOS though.


## Table of Contents

* [Installation](#installation)
* [Including Dotfiles](#including-dotfiles)


## Installation

To use these dotfiles, simply clone this repository to the home directory and run the installation script.

```bash
cd ~
git clone https://github.com/willforde/dotfiles.git .dotfiles
cd .dotfiles
sh install.sh
```

This will symlink the dotfiles in the `dotfiles` directory to the home directory. Any existing dotfiles in the home directory will be backed up to a backup folder within this repo.

Any required dependencies will be installed automatically.


## Including Dotfiles

After installation is complete, there will be a script added to the `~/.local/bin` directory that can be used to add dotfiles to the repo. When used it will move the given file to the dotfiles repo and create a symlink for the file in the home directory.

```bash
config-add <file>
```
