#!/usr/bin/env bash

# set a default on the terminal name
SELECTED_TERMINAL=false

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

##########
## Ask users which shell to set ambientum into
##########
function askshell() {
    # set the question title to
    echo "Please select your terminal, where Ambientum will set it's aliases and scripts:"

    PS3='Your terminal: '
    options=("Bash" "ZSH" "Fish" "Git Bash" "PowerShell" "Quit")
    select opt in "${options[@]}"
    do
        case $opt in
            "Bash")
                SELECTED_TERMINAL="bash"
                echo -e " Setting up Ambientum for Bash"
                break
                ;;
            "ZSH")
                SELECTED_TERMINAL="zsh"
                echo -e "\nSetting up Ambientum for ZSH"
                break
                ;;
            "Fish")
                SELECTED_TERMINAL="fish"
                echo -e "\nSetting up Ambientum for Fish"
                break
                ;;
            "Git Bash")
                SELECTED_TERMINAL="gitbash"
                echo -e "\nSetting up Ambientum for Git Bash (Windows)"
                break
                ;;
            "PowerShell")
                SELECTED_TERMINAL="powershell"
                echo -e "\nSetting up Ambientum for PowerShell"
                break
                ;;
            "Quit")
                echo -e "\n\n\e[31mAborted!\e[39m\n\n"
                exit
                break
                ;;
            *) echo invalid option;;
        esac
    done
}

# greet
function greet() {
    # Welcome users
    echo -e "\n\e[32m==========================================\e[39m"
    echo -e "\e[32m==      AMBIENTUM Setup Script :)       ==\e[39m"
    echo -e "\e[32m==========================================\e[39m\n\n"
}

function setup_fish() {
    # download script file
    curl -s $FISH_SCRIPT_URL > ~/.ambientum_rc

    # If not upgrade, auto source file
    if [ $UPGRADE_ONLY == false ]; then
        echo "source ~/.ambientum_rc" >> ~/.config/fish/config.fish
    fi

    echo -e "\n\nCongratulations, Ambientum successfully configured Fish\n\n"
}

function setup_bash() {
    # download script file
    curl -s $BASH_SCRIPT_URL > ~/.ambientum_rc

    # If not upgrade, auto source file
    if [ $UPGRADE_ONLY == false ]; then
        echo "source ~/.ambientum_rc" >> ~/.bashrc
    fi

    echo -e "\n\nCongratulations, Ambientum successfully configured Bash\n\n"
}

function setup_zsh() {
    # download script file
    curl -s $ZSH_SCRIPT_URL > ~/.ambientum_rc

    # If not upgrade, auto source file
    if [ $UPGRADE_ONLY == false ]; then
        echo "source ~/.ambientum_rc" >> ~/.zshrc
    fi

    echo -e "\n\nCongratulations, Ambientum successfully configured ZSH\n\n"
}

function setup_gitbash() {
    # download script file
    curl -s $GITBASH_SCRIPT_URL > ~/.ambientum_rc
    echo "Please, manually source ~/.ambientum_rc"
}

function setup_powershell() {
    # download script file
    curl -s $POWERSHELL_SCRIPT_URL > ~/.ambientum_rc
    echo "Please, manually source ~/.ambientum_rc"
}


# Welcome users
greet

# ask for shell
askshell

# depending on shell, trigger the correct setup function
case "$SELECTED_TERMINAL" in
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
