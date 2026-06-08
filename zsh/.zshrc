# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

set -o vi

source $HOME/.sdkman/bin/sdkman-init.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.

source <(fzf --zsh)

# SECTION: Environment variables

# Default Editor
export VISUAL=nvim
export EDITOR="$VISUAL"

# App development
export ANDROID_HOME="$HOME/Android/Sdk" # Depending on the Android SDK path.
export ANDROID_SDK_ROOT="$HOME/Android/Sdk"  # Depending on the Android SDK path.
export PATH=${PATH}:${ANDROID_HOME}/tools
export PATH=${PATH}:${ANDROID_HOME}/platform-tools

# Java
export JAVA_HOME="$HOME/.sdkman/candidates/java/current"
export PATH="$PATH:${JAVA_HOME}"

# Go
export GOPATH=$HOME/go

# Kubernetes
source <(kubectl completion zsh)
export KUBECONFIG="$(find -L ~/.kube/config ~/.kube/config.d -type f 2>/dev/null | sort | paste -s -d :)"

# Mise
eval "$(~/.local/bin/mise activate zsh)"


export PATH=${PATH}:~/bin

# SECTION: Aliases

# General
alias cl="clear"
# Neovim
alias v="nvim"
alias vim="nvim"
# Git
alias lg="lazygit"
# Timewarrior
alias week="timew week"
alias startw="timew start work"
alias stopw="timew stop work"
# Taskwarrior
alias ta="task add"
alias tl="task next"
alias tg="task next | grep"
# File watcher override
alias watcher-limit="sudo sysctl -w fs.inotify.max_user_watches=10000000"
# NPM
alias npmstart="npm install && npm run start"
# Python
alias python="python3"
# Navigation
alias backend="cd $HOME/Programming/snapaddy-backend/packages/server && nvm use 20"
# Daily notes
alias daily="tmuxinator start daily-notes"
alias dailyDown="tmuxinator stop daily-notes"
alias yesterday="nvim ~/Notes/Daily-Notes/$(date --date="yesterday" +%d-%m-%Y).md"
# Start day
alias krokodil=~/Scripts/start-day.sh
# Rush
alias featstart="rushx build && rushx start:feat"
alias fullrush="rush install && rush build-only && rush gen:code"
alias rushpart="rush install && rush build-only && rush start:partial"
alias rushto="rush install && rush build-only --to ."
alias rxb="rushto"
alias rxt="rushx _phase:test"
alias rxe="rushx test:e2e"
alias rb="rush install && rush build-only"
alias rsf="rushx build && rushx start:feat"
alias vibe="opencode --continue --hostname 127.0.0.1 --port 4096"

# Tmuxinator
tmux_environments=(~/.config/tmuxinator/*.yml(:t:r))
# Tmux environment selectors
up() {
  local env
  env=$(print -l $tmux_environments | fzf --color light)
  if [[ -n "$env" ]]; then
    tmuxinator start $env
  fi
}
down() {
  local env
  env=$(print -l $tmux_environments | fzf --color light)
  if [[ -n "$env" ]]; then
    tmuxinator stop $env
  fi
}

# Load Angular CLI autocompletion.
# source <(ng completion script)

# opencode
export PATH=/home/niklas/.opencode/bin:$PATH

# opencode
export PATH=/home/niklasv/.opencode/bin:$PATH

# Wrap npm/pnpm registry auth via 1Password (op run)
[ -f "$HOME/.config/zsh/npm-op.zsh" ] && source "$HOME/.config/zsh/npm-op.zsh"
