# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="eastwood"

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
plugins=(git tmux docker)

source $ZSH/oh-my-zsh.sh

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"
ZSH_TMUX_AUTOSTART="true"
# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

source $HOME/shell/options
source $HOME/shell/plugins
source $HOME/shell/tools
source $HOME/shell/funcs
source $HOME/shell/aliases
#source $HOME/shell/bindings

export PATH=$PATH:$HOME/.poetry/bin:/Users/$USER/go/bin
export PATH="/opt/homebrew/opt/python@3.8/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/Users/$USER/local/bin:$PATH"


alias g++="g++ -std=c++17"
export HOMEBREW_NO_AUTO_UPDATE=1

alias cat="bat"

# export CFLAGS=$(gdal-config --cflags)

 # Nix
 if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
    . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
 fi
 # End Nix
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"

export LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@3/include"
export PATH="/Users/$USERNAME/.pulumi/bin:/opt/homebrew/opt/curl/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
alias vim=nvim
eval "$(starship init zsh)"

alias ls='eza'
export CLAUDE_CODE_NO_FLICKER=1

# F6 - EC2 instance selector with SSM
bindkey -s "^[[17~" 'ec2-ssm\n'


# bun completions
[ -s "/Users/$USER/.bun/_bun" ] && source "/Users/$USER/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
. "$HOME/.cargo/env"

export PATH=$HOME/development/flutter/bin:$PATH

alias uber-apk-signer="java -jar /usr/local/bin/uber-apk-signer.jar"
alias apktool="java -jar /usr/local/bin/apktool"

export GPG_TTY=$(tty)

alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias docker='podman'
# Machine/work-specific secrets & aliases (gitignored)
[ -f "$HOME/shell/private" ] && source "$HOME/shell/private"
alias codex-yolo="codex --dangerously-bypass-approvals-and-sandbox"

export PATH="$HOME/.codeium/windsurf/bin:$PATH"
# npm global prefix (nix nodejs installs into a read-only store, so npm -g needs its own prefix)
export PATH="$HOME/.npm-global/bin:$HOME/.local/bin:$PATH"
export XDG_CONFIG_HOME=$HOME/.config
export ZSH_TMUX_CONFIG="$XDG_CONFIG_HOME/tmux/tmux.conf"


[ -f "$HOME/.atuin/bin/env" ] && . "$HOME/.atuin/bin/env"
command -v atuin >/dev/null && eval "$(atuin init zsh)"

# direnv + nix-direnv for auto-activating nix dev shells
command -v direnv >/dev/null && eval "$(direnv hook zsh)"
for _d in /run/current-system/sw $HOME/.nix-profile; do
  [ -f "$_d/share/nix-direnv/direnvrc" ] && source "$_d/share/nix-direnv/direnvrc" && break
done

# Added by Antigravity
export PATH="/Users/pratikgajjar/.antigravity/antigravity/bin:$PATH"
alias librewolf-fix="xattr -dr com.apple.quarantine /Applications/LibreWolf.app"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc' ]; then . '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc'; fi

# override oh-my-zsh gcm to use main
alias gcm='git checkout main'

# Save tmux session (resurrect) then reboot — restores exact layout on next boot
alias reboot-save='~/.config/tmux/plugins/tmux-resurrect/scripts/save.sh && sudo reboot'
alias codex="codex-yolo"
