#!/usr/bin/env zsh
#
# Local convenient alias

# Pacman aliases
alias pacin="sudo /usr/bin/pacman --needed -Sy"
alias pacup="sudo /usr/bin/pacman -Syu"
alias pacrm="sudo /usr/bin/pacman -Rs"
alias pacinfo="/usr/bin/pacman -Si"

# Yay aliases
alias yayup="yay -Syu --devel --timeupdate"

# Protection aliases
alias chown="chown --preserve-root"
alias chmod="chmod --preserve-root"
alias chgrp="chgrp --preserve-root"
alias su="su -"

# Human frendly output
alias df="df -h"

# Extras
alias untar="tar -xvf"
