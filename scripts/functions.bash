#!/bin/bash
set -eu

# Colors and formatting
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m' # No Color


# Populate the home directory with dotfiles
function populateDotfiles() {
    # Loop over each and every dotfile in the dotfiles directory
    echo "Creating symlinks for dotfiles..."
    find "$1" -type f | while IFS= read -r file; do
        # Convert the dotfile path to a home file path
        home_file="$HOME/${file#$1/}"
        relative_home_file="~${home_file/#$HOME/}"

        # The full path for the backup file
        backup_file="${file/$1/$BACKUP_DIR}"

        # Home file is already a symlink, skiping for safety
        if [ -L "$home_file" ]; then
            echo "Skipping $relative_home_file - already a symlink"
            continue
        
        # If the backup file already exists, skip
        elif [ -e "$backup_file" ]; then
            echo "Skipping $relative_home_file - already backed up"
            continue
        
        # If the home file exists, backup the file before creating the symlink
        elif [ -e "$home_file" ]; then
            # Ensure the backup directory exists
            mkdir -p "$(dirname "$backup_file")"

            # Move the home file to the backup directory
            echo "Backing up $relative_home_file"
            mv $home_file $backup_file
        fi

        # Create the symlink
        echo "Creating symlink for $relative_home_file"
        mkdir -p "$(dirname "$home_file")"
        ln -s $file $home_file
    done
}


# Function to clear the last n lines
function clear_lines() {
    local lines=$1
    echo -en "\033[${lines}A"  # Move cursor up n lines
    echo -en "\033[J"  # Clear from cursor to end of screen
}


# Ensure selection is validl, returning label as key
function validate_option_selection() {
    local -n array=$1
    local selection=$2

    if [[ "$selection" == "" ]]; then
        return 0
    fi

    # Look for the selected option
    for item in "${array[@]}"; do
        IFS="|" read -r key label <<< "$item"
        
        if [[ "$selection" == "$key" ]]; then
            # Here we return the key for further processing
            echo "$label"
            return 0
        fi
    done

    # If we get here, the selection wasn't valid
    return 1
}


# Show menu of options
function show_option_menu() {
    local title=$1    # Title for the menu
    local -n opts=$2  # Name reference to the array passed as argument
    
    echo -e "${BOLD}${title}:${NC}"
    for item in "${opts[@]}"; do
        IFS="|" read -r key label <<< "$item"
        echo -e "${YELLOW}${key}${BLUE}) ${GREEN}${label}${NC}"
    done

    while true; do
        echo -en "\n${BOLD}Enter your choice (leave blank to skip):${NC} "
        read -n 1 result
        echo

        set +e
        RET=$(validate_option_selection opts "$result")
        if [ $? -eq 0 ]; then
            break
        else
            echo -e "${RED}Invalid option. Please try again.${NC}"
            sleep 1
            clear_lines 3
        fi
        set -e
    done
}


# Ask the user if they want to install the desktop applications
function ask_yes_no() {
    local title=$1

    while true; do
        # Load answer from cache is available
        echo -en "${BOLD}${title}:${NC} ${BLUE}[${YELLOW}Y${BLUE}/${YELLOW}n${BLUE}]${NC}: "
        read -n 1 answer

        # Convert answer to lowercase
        case $(echo "$answer" | tr '[:upper:]' '[:lower:]') in
            "")
                return 0 # Return true
                ;;
            "y")
                echo
                return 0 # Return true
                ;;
            "n")
                echo
                return 1 # Return false
                ;;
            *)
                echo -e "\n${RED}Invalid input. Please enter 'y' or 'n'.${NC}"
                sleep 1
                clear_lines 2
                unset cached_answer
                ;;
        esac
    done
}


function ask_for_applications() {
    # Return cached response or ask for user input
    if [ -z "${cached_apps_answer+x}" ]; then # no cache
        set +e
        ask_yes_no "Would you like to install the desktop apps, like Firefox and VSCode?"
        cached_apps_answer=$?
        set -e
    fi
    return $cached_apps_answer
}

function ask_for_games() {
    # Return cached response or ask for user input
    if [ -z "${cached_steam_answer+x}" ]; then # no cache
        set +e
        ask_yes_no "Will you be playing games on this system?"
        cached_steam_answer=$?
        set -e
    fi
    return $cached_steam_answer
}
