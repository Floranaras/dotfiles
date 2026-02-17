# Oh My Zsh Configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source "$ZSH/oh-my-zsh.sh"

# PATH Configuration
export PATH="/usr/local/mysql/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$CATALINA_HOME/bin"
export PATH="$HOME/.npm-global/bin:$PATH"

# Environment Variables
export GHOSTTY_CONFIG="$HOME/.config/ghostty/config"
export CATALINA_HOME=/usr/share/tomcat9
export EDITOR="nvim"
export VISUAL="nvim"
export QT_QPA_PLATFORMTHEME=qt5ct

# Graphics Settings (Mesa/OpenGL)
export MESA_GL_VERSION_OVERRIDE=4.5
export MESA_GLSL_VERSION_OVERRIDE=450
export vblank_mode=0

# Cargo (Rust)
. "$HOME/.cargo/env"

# Aliases - General
alias vi="nvim"
alias ctags="/opt/homebrew/bin/ctags"

# Aliases - eza (ls replacement)
alias ls="eza --icons"
alias ll="eza -lg --icons"
alias la="eza -lag --icons"
alias lt="eza -lag --icons"
alias lt1="eza -lag --level=1 --icons"
alias lt2="eza -lag --level=2 --icons"
alias lt3="eza -lag --level=3 --icons"
alias l="eza --tree --git-ignore --icons --level=5 --group-directories-first"
alias l1="eza --tree --no-permissions --no-user --no-time --no-filesize --icons --level=3"
alias l2="eza --tree --no-permissions --no-user --no-time --no-filesize --icons --level=4"
alias lw="eza --tree --git-ignore --no-permissions --no-user --no-time --no-filesize --icons --level=5"

# Aliases - Gradle
alias grun="./gradlew run -q --console=plain"
alias report="open build/reports/tests/test/index.html"

# Functions
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

# Run the organizer script
[[ "$OSTYPE" == "darwin"* ]] && /usr/local/bin/organize-downloads.sh

export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"
alias fastfetch="anifetch anifetch/src/anifetch/assets/badapple.mp4"

export PATH="$HOME/Dotfiles/bin:$PATH"
eval "$(zoxide init zsh)"
bindkey -s '^f' 'tmux-sessionizer\n'

alias jqinit='npm init -y && npm install --save-dev @types/jquery'
