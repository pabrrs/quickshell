#!/bin/bash



quickshell_label() {
    echo ""
    echo "⚡️ quickshell ⚡️"
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

# Function to handle arrow key navigation
handle_input() {
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

# Read options from file and populate the array
IFS=$'\n' read -d '' -r -a options < ~/.quickshell

# Initialize selected index
selected_index=0

# Main loop
while true; do
    display_dropdown
    handle_input
done
