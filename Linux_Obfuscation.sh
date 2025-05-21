#!/bin/bash

# Command obfuscation function
obfuscate_command() {
    local cmd="$1"
    # Apply substitutions
    local obfuscated_cmd=$(echo "$cmd" | sed \
        -e 's/,/{ls,-la}/g' \
        -e 's/ /${IFS}/g' \
        -e 's/;/${LS_COLORS:10:1}/g' \
        -e 's#/#${PATH:0:1}#g')

    # Check if the command was modified
    if [[ "$obfuscated_cmd" == "$cmd" ]]; then
        echo -e "\n⚠️  No specific character was modified."
        echo -e "💡 Possible obfuscation examples:"
        echo -e "   - Use random uppercase letters: WhoAmI"
        echo -e '	Run the command with: $(a="WhOaMi";printf %s "${a,,}")'
        echo -e "   - Add double quotes: who''ami"
        echo -e "   - Inject in the middle with \$@ or even \\. Example: who\$@am\\i"
    else
        echo -e "\n🔹 Obfuscated command:"
        echo "$obfuscated_cmd"
    fi
}

# Command reversal function
reverse_command() {
    local cmd="$1"
    local reversed_cmd=$(echo "$cmd" | rev)

    echo -e "\n🔹 Reversed command:"
    echo "$reversed_cmd"

    echo -e "\n💡 To execute your command, use:"
    echo "\$(rev<<<'$reversed_cmd')"
}

# Base64 encoding function
encode_base64() {
    local cmd="$1"
    local encoded_cmd=$(echo -n "$cmd" | base64)

    echo -e "\n🔹 Command encoded in Base64:"
    echo "$encoded_cmd"

    echo -e "\n💡 To execute your command, use:"
    echo "bash -c \"\$(echo '$encoded_cmd' | base64 -d)\""
    echo "Or bash<<<\$(base64 -d<<<$encoded_cmd)"
}

# Interactive menu
while true; do
    # Ask the user to enter a command
    read -p "Enter the command to modify: " cmd

    # Check if the command is empty
    if [[ -z "$cmd" ]]; then
        echo -e "❌ Error: You must enter a command!"
        continue
    fi

    echo -e "\n🔹 What would you like to do with this command?"
    echo "1. Obfuscate the command"
    echo "2. Reverse the command"
    echo "3. Encode in Base64"
    echo "4. Quit"

    # Ask for user's choice
    read -p "Enter your choice (1-4): " choice

    case $choice in
        1) obfuscate_command "$cmd" ;;
        2) reverse_command "$cmd" ;;
        3) encode_base64 "$cmd" ;;
        4) echo "👋 Goodbye!"; exit ;;
        *) echo "❌ Invalid option, please choose between 1 and 4." ;;
    esac

    echo -e "\n🔄 Returning to menu..."
done
