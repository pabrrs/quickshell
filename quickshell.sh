#!/bin/sh

BRAND="⚡️ quickshell ⚡️"
HEADLINE="Fast select day-to-day commands, because ⏰ is 💰!"
# Initialize selected index
selected_index=0

# Read options from file and populate the array
read_commands() {
    IFS=$'\n' read -d '' -r -a options < ~/.quickshell
}
# read ~/.quickshell
read_commands

quickshell_label() {
    echo ""
    echo $BRAND
}

# Function to clear the screen
clear_screen() {
    printf "\033c"
}

# Function to display the dropdown list
display_dropdown() {
    clear_screen
    quickshell_label
    echo "Select a command:"
    for ((i=0; i<${#options[@]}; i++)); do
        if [ $i -eq $selected_index ]; then
            echo "> $(tput bold)${options[$i]}$(tput sgr0)"
        else
            echo "  ${options[$i]}"
        fi
    done
}

remove_command() {
    read -rsn1 key
    case $key in
        A)  # Up arrow
            ((selected_index--))
            ;;
        B)  # Down arrow
            ((selected_index++))
            ;;
        "") # Enter key
            clear_screen
            quickshell_label
            echo "Running ${options[$selected_index]}"
            echo ""
            eval "${options[$selected_index]}" 
            exit 0
            ;;
    esac

    # Ensure selected index stays within bounds
    if [ $selected_index -lt 0 ]; then
        selected_index=$((${#options[@]} - 1))
    elif [ $selected_index -ge ${#options[@]} ]; then
        selected_index=0
    fi
}

# Function to handle arrow key navigation
handle_input() {
    display_dropdown
    read -rsn1 key
    case $key in
        A)  # Up arrow
            ((selected_index--))
            ;;
        B)  # Down arrow
            ((selected_index++))
            ;;
    esac

    # Ensure selected index stays within bounds
    if [ $selected_index -lt 0 ]; then
        selected_index=$((${#options[@]} - 1))
    elif [ $selected_index -ge ${#options[@]} ]; then
        selected_index=0
    fi
}

execute_command() { 
    if [[ $key == "" ]]; then  # Enter key
        clear_screen
        echo ""
        echo "[${BRAND}] ${options[$selected_index]}"
        eval "${options[$selected_index]}" 
        exit 0
        break
    fi
}

# Check for command line arguments for adding new commands
if [[ "$1" == "--add" || "$1" == "-a" ]]; then
    read -p "[${BRAND}] Add your new command: " new_command
    if grep -Fxq "$new_command" ~/.quickshell; then
        echo "⚠️  Command is already registered."
    else
        echo "$new_command" >> ~/.quickshell
        read_commands
        echo "🚀  Command added!"
    fi
    exit 0
fi

# Check for command line arguments for removing commands
if [[ "$1" == "--remove" || "$1" == "-r" ]]; then
    read_commands
    while true; do
        handle_input
        if [[ $key == "" ]]; then  # Enter key
            command_to_remove="${options[$selected_index]}"
            sed -i '' "/^$command_to_remove$/d" ~/.quickshell
            echo "🗑️  Command removed!"
            read_commands
            break
        fi
    done
    exit 0
fi

# Check for command line arguments for listing commands
if [[ "$1" == "--list" || "$1" == "-l" ]]; then
    cat ~/.quickshell
    exit 0
fi

# Check for command line arguments for help
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    echo "${BRAND}"
    echo ""
    echo "${HEADLINE}"
    echo ""
    echo "    --add, -a: Add a new command to the list."
    echo ""
    echo "    --remove, -r: Remove a command from the list."
    echo ""
    echo "    --list, -l: List all registered commands."
    echo ""
    echo "    --help, -h: Show this help message."
    echo ""
    exit 0
fi


# Main loop
while true; do
    handle_input
    execute_command
done
