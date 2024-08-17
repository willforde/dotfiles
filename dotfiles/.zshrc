# ------------------------------
# Dependencies
# ------------------------------
# List of all dependencies required for the config to work at it's best
# Repo:
# - git - show git repository status
# - zsh - the shell itself
# - zsh-syntax-highlighting - Fish shell like syntax highlighting for Zsh
# - zsh-autosuggestions - Fish-like autosuggestions for zsh
# - zsh-completions - Additional completion definitions for Zsh
# AUR
# - oh-my-zsh-git - managed zsh config
# - chroma - add syntax highlighting to files
# - archey4 - nice display of system info on terminal start


# ------------------------------
# Oh-My-Zsh Configuration
# ------------------------------

# Path to your oh-my-zsh installation.
export ZSH=/usr/share/oh-my-zsh

# Set name of the theme to load. (Optional)
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="kennethreitz"

# Path to the cache folder. Used to store and cache all data used by plugins and completion scripts
ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/ohmyzsh"

# Disable auto-update checks.
zstyle ':omz:update' mode disabled

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Add wisely, as too many plugins slow down shell startup.
plugins=(git colored-man-pages colorize common-aliases sudo)

# Load the Oh-my-zsh configuration
source ${ZSH}/oh-my-zsh.sh

# Source syntax highlighting & auto suggestions
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Change highlighting color of man pages to green
less_termcap[md]="${fg_bold[green]}"


# ------------------------------
# Misc
# ------------------------------

# Output system info using archey3 (https://lclarkmichalek.github.io/archey3/)
[ -r /usr/bin/archey4 ] && clear && /usr/bin/archey4

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Replace VI with nano as the default text editor
export VISUAL=nano
export EDITOR=nano

# Load local aliases
source ${HOME}/.aliases.zsh

# Load local functions
# source ${HOME}/.functions
