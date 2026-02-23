# ==============================================================================
# ZSH CONFIGURATION
# ==============================================================================

# --- 1. Framework Initialization (Oh My Zsh) ----------------------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)

# Load Oh My Zsh
source "$ZSH/oh-my-zsh.sh"

# --- 2. Environment Variables -------------------------------------------------
export EDITOR="nvim"
export VISUAL="nvim"
export GHOSTTY_CONFIG="$HOME/.config/ghostty/config"
export CATALINA_HOME="/usr/share/tomcat9"
export QT_QPA_PLATFORMTHEME="qt5ct"

# Graphics / Mesa Settings
export MESA_GL_VERSION_OVERRIDE=4.5
export MESA_GLSL_VERSION_OVERRIDE=450
export vblank_mode=0

# --- 3. Path Configuration ----------------------------------------------------
# Define paths in an array for readability, then join them
typeset -U path  # -U ensures unique entries (no duplicates)

# Prepend paths (Priority order)
path=(
    "$HOME/Dotfiles/bin"
    "$HOME/.local/bin"
    "$HOME/.local/share/nvim/mason/bin"
    "$HOME/.npm-global/bin"
    "/opt/homebrew/opt/openjdk/bin"
    "/usr/local/mysql/bin"
    "$CATALINA_HOME/bin"
    $path
)

# --- 4. Tool Initializations --------------------------------------------------
# Rust/Cargo
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# Zoxide (Smart cd)
eval "$(zoxide init zsh)"

# Keybindings
# CTRL-f: Open tmux-sessionizer
bindkey -s '^f' 'tmux-sessionizer\n'

# --- 5. Aliases ---------------------------------------------------------------

# General
alias vi="nvim"
alias ctags="/opt/homebrew/bin/ctags"
alias fastfetch="anifetch anifetch/src/anifetch/assets/badapple.mp4"

# Eza (LS Replacement) - Modern Directory Listing
alias ls="eza --icons"
alias ll="eza -lg --icons"
alias la="eza -lag --icons"
alias lt="eza -lag --icons"
alias l="eza --tree --git-ignore --icons --level=5 --group-directories-first"
alias lw="eza --tree --git-ignore --no-permissions --no-user --no-time --no-filesize --icons --level=5"

# Eza Tree Shortcuts (Depth 1-4)
alias lt1="eza -lag --level=1 --icons"
alias lt2="eza -lag --level=2 --icons"
alias lt3="eza -lag --level=3 --icons"
alias l1="eza --tree --no-permissions --no-user --no-time --no-filesize --icons --level=3"
alias l2="eza --tree --no-permissions --no-user --no-time --no-filesize --icons --level=4"

# Development Tools (Gradle / Node)
alias grun="./gradlew run -q --console=plain"
alias report="open build/reports/tests/test/index.html"
alias jqinit='npm init -y && npm install --save-dev @types/jquery'

# --- 6. Custom Functions ------------------------------------------------------

# Initialize a Java Gradle project
ginit() {
    local project_name=$1
    if [[ -z "$project_name" ]]; then
        echo "Usage:   ginit <project-name>"
        echo "Example: ginit helloWorld"
        return 1
    fi
    
    echo "Creating Java project with package: com.$project_name"
    gradle init --type java-application --package "$project_name"
}

# --- 7. Startup Scripts -------------------------------------------------------

# Run organizer script on macOS only. 
# Added '&!' to run in background (disowned) to prevent slow terminal startup.
if [[ "$OSTYPE" == "darwin"* ]]; then
    [[ -f "/usr/local/bin/organize-downloads.sh" ]] && /usr/local/bin/organize-downloads.sh &!
fi
