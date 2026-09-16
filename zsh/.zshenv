# source "$HOME/.cargo/env"

# XDG
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$XDG_CONFIG_HOME/local/share
export XDG_CACHE_HOME=$XDG_CONFIG_HOME/cache

# editor
export EDITOR="nvim"
export VISUAL="nvim"

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.zhistory"    # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file
# . "$HOME/.cargo/env"

export PATH="$PATH:/home/lfccmbr/.config/.foundry/bin"

# SSH agent (managed by systemd --user unit ssh-agent.service)
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# uv
export PATH="/home/dsedlacek/.config/local/share/../bin:$PATH"
