#!/usr/bin/env bash

######
## To automatically set ambientum on your terminal, please use
##
## curl -sSL https://goo.gl/KhJecM | bash
##
######

# mode
set -e

# Detect user terminal
USER_SHELL=$(basename $SHELL)

# If Upgrade is set, do not auto register for auto init
UPGRADE_ONLY=false

# enable all repositories if any specified
if [[ $1 == "upgrade" ]]; then
    UPGRADE_ONLY=true
fi

# define scripts url
BASH_SCRIPT_URL="https://raw.githubusercontent.com/codecasts/ambientum/master/commands.bash"
FISH_SCRIPT_URL="https://raw.githubusercontent.com/codecasts/ambientum/master/commands.fish"
GITBASH_SCRIPT_URL="https://raw.githubusercontent.com/codecasts/ambientum/master/commands.git-bash"
ZSH_SCRIPT_URL="https://raw.githubusercontent.com/codecasts/ambientum/master/commands.bash"
POWERSHELL_SCRIPT_URL="https://raw.githubusercontent.com/codecasts/ambientum/master/commands.ps1"


# greet
function greet() {
    # Welcome users
    echo -e "\n\e[32m==========================================\e[39m"
    echo -e "\e[32m==      AMBIENTUM Setup Script :)       ==\e[39m"
    echo -e "\e[32m==========================================\e[39m\n\n"
}

function setup_fish() {
    # info
    echo -e "Setting up Ambientum for Fish at ~/.ambientum_rc"

    # download script file
    curl -s $FISH_SCRIPT_URL > ~/.ambientum_rc

    # If not upgrade, auto source file
    if [ $UPGRADE_ONLY == false ]; then
        echo "source ~/.ambientum_rc" >> ~/.config/fish/config.fish
    fi

    echo -e "Congratulations, Ambientum successfully configured Fish\n\n"
}

function setup_bash() {
    # info
    echo -e "Setting up Ambientum for Bash"

    # download script file
    curl -s $BASH_SCRIPT_URL > ~/.ambientum_rc

    # If not upgrade, auto source file
    if [ $UPGRADE_ONLY == false ]; then
        echo "source ~/.ambientum_rc" >> ~/.bashrc
    fi

    echo -e "Congratulations, Ambientum successfully configured Bash\n\n"
}

function setup_zsh() {
    # info
    echo -e "Setting up Ambientum for ZSH"

    # download script file
    curl -s $ZSH_SCRIPT_URL > ~/.ambientum_rc

    # If not upgrade, auto source file
    if [ $UPGRADE_ONLY == false ]; then
        echo "source ~/.ambientum_rc" >> ~/.zshrc
    fi

    echo -e "Congratulations, Ambientum successfully configured ZSH\n\n"
}

function setup_gitbash() {
    # info
    echo -e "Setting up Ambientum for Git Bash (Windows)"

    # download script file
    curl -s $GITBASH_SCRIPT_URL > ~/.ambientum_rc

    # not automatically yet
    echo "Please, manually source ~/.ambientum_rc"
}

function setup_powershell() {
    # info
    echo -e "\nSetting up Ambientum for PowerShell"

    # download script file
    curl -s $POWERSHELL_SCRIPT_URL > ~/.ambientum_rc

    # not automatically yet
    echo "Please, manually source ~/.ambientum_rc"
}


# Welcome users
greet

# depending on shell, trigger the correct setup function
case "$USER_SHELL" in
    "bash")
        setup_bash
        ;;
    "fish")
        setup_fish
        ;;
    "zsh")
       setup_zsh
       ;;
    "gitbash")
        setup_gitbash
        ;;
    "powershell")
        setup_powershell
        ;;
    *)
        #
    ;;
esac

echo -e "\n\nAmbientum is set to automatically be sources at terminal session start.\n"
echo -e "In case of Ambientum commands are not working, please use:\n\n"
echo -e "source ~/.ambientum_rc\n\n"
echo -e "or use manual setup instructions on repository\n\n"