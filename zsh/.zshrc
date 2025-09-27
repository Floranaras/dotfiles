# If you come from bash you might have to change your $PATH.
# export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export PATH="/usr/local/mysql/bin:$PATH"

# Set name of the theme to load.
ZSH_THEME="robbyrussell"

# Load plugins
plugins=(git)

# Source Oh My Zsh
source "$ZSH/oh-my-zsh.sh"

# Set Rust and Ghostty config
. "$HOME/.cargo/env"
export GHOSTTY_CONFIG="$HOME/.config/ghostty/config"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# Aliases
alias ctags="/opt/homebrew/bin/ctags"


# Created by `pipx` on 2025-07-08 08:32:35
export PATH="$PATH:/Users/callo/.local/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.local/bin"

# eza 
alias l="eza --tree --no-permissions --no-user --no-time --no-filesize --icons --level=2"
alias l1="eza --tree --no-permissions --no-user --no-time --no-filesize --icons --level=3"
alias l2="eza --tree --no-permissions --no-user --no-time --no-filesize --icons --level=4"
alias ls="eza --icons"
alias ll="eza -lg --icons"
alias la="eza -lag --icons"
alias lt="eza -lag --icons"
alias lt1="eza -lag --level=1 --icons"
alias lt2="eza -lag --level=2 --icons"
alias lt3="eza -lag --level=3 --icons"

# gradle
alias grun="./gradlew run -q --console=plain"
ginit() {
    if [ -z "$1" ]; then
        echo "Usage: ginit <project-name>"
        echo "Example: ginit helloWorld"
        echo "Creates Java project with package com.<project-name>"
        return 1
    fi
    
    echo "Creating Java project with package: com.$1"
    gradle init --type java-application --package "$1"
}

alias vi="nvim"
