# Dotfiles

This repository contains my personal dotfiles, which are used to configure my development environment.


## Table of Contents

* [Installation](#installation)
* [Including Dotfiles](#including-dotfiles)


## Installation

To use these dotfiles, simply clone this repository to your home directory and run the installation script.

```bash
cd ~
git clone https://github.com/willforde/dotfiles.git
cd dotfiles
sh install.sh
```

This will symlink the dotfiles in the `dotfiles` directory to your home directory. Any existing dotfiles in your home directory will be backed up to a backup folder within this repo.


## Including Dotfiles

After installation is complete, there will be a script added to the `~/.local/bin` directory that can be used to add dotfiles to the repo. When used it will move a file to the dotfiles repo and create a symlink in your home directory.

```bash
config-add <file>
```
