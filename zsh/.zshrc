# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# SOURCE FILES #
#--------------#
source $ZDOTDIR/theme.zsh
source $ZDOTDIR/zsh-colored-man-page

setopt HIST_IGNORE_ALL_DUPS  # do not put duplicated command into history list
setopt HIST_SAVE_NO_DUPS  # do not save duplicated command
setopt HIST_REDUCE_BLANKS  # remove unnecessary blanks
setopt INC_APPEND_HISTORY_TIME  # append command to history file immediately after execution
setopt EXTENDED_HISTORY  # record command start time

bindkey '\e[H' beginning-of-line
bindkey '\e[F' end-of-line
bindkey '\e[3~' delete-char
bindkey '\e[2~' overwrite-mode
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
if [[ -n "$TMUX" ]]; then
    bindkey "^[[1;5C" forward-word
    bindkey "^[[1;5D" backward-word
    bindkey '\e[1~' beginning-of-line
    bindkey '\e[4~' end-of-line
fi

#  ALIASES  #
#-----------#
# ls -> exa
alias l='eza -hla --time-style "+%y-%m-%d %H:%M"'
alias ll='eza -hlao --git --total-size --time-style "+%y-%m-%d %H:%M"'
alias ls='eza'

# cat -> bat
export BAT_THEME="base16"
alias cat='bat'
alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'


alias curl='curlie'

export MYVIMRC=$HOME/.config/nvim/init.lua
alias v='nvim'

alias mkdir="mkdir -pv"
alias mk='mkdir'

alias gxx='g++ -Wall -pedantic -Wextra --std=c++11 -g'

alias gxo='g++ -Wall -pedantic -Wextra --std=c++11 -g -o'
alias wttr='curl "wttr.in/prague?2fQm"'

alias ip='ip -color=auto'
alias grep='grep --color=auto'
alias bc="bc -l"
alias mkdir="mkdir -pv"
alias diff='colordiff'
alias cl='clear'
alias k='kubectl'

alias tsu='echo "Tailscale up"; sudo tailscale up --accept-routes'
alias tsd='echo "Tailscale down"; sudo tailscale down'
alias tss='sudo tailscale status'

alias goclean='go clean -cache; go clean -modcache; go clean -testcache'

alias grd='cd $(git rev-parse --show-cdup)'
alias gpn='git push --no-verify'
alias gpfn='git push --force-with-lease --no-verify'
alias grssh1='git reset --soft HEAD~1'
alias grshh1='git reset --hard HEAD~1'

alias sssh='eval "$(ssh-agent)"; ssh-add ~/.ssh/id_ed25519'

alias devbox-up='cd ~/dev/0xsequence/devbox && make up && cd -'
alias devbox-down='cd ~/dev/0xsequence/devbox && make down && cd -'

## get rid of command not found ##
alias cd..='cd ..'
 
## a quick way to get out of current directory ##
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias .2='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../../'

autoload -Uz compinit && compinit

_comp_options+=(globdots) # With hidden files
source $ZDOTDIR/completion.zsh

export GIT_EDITOR='nvim +startinsert!'

export _ZO_ECHO='0'
eval "$(zoxide init --cmd cd zsh)"

source <(kubectl completion zsh)

# Source ASDF set-env script for Go
. ~/.asdf/plugins/go/set-env.zsh
. ~/.asdf/asdf.sh

# go
export GOPATH=$(asdf where go)/packages
export GOROOT=$(asdf where go)/go
export PATH="${PATH}:$(go env GOPATH)/bin"

# Use the Go module mirror and checksum database by default.
# See https://proxy.golang.org for details.
export GOPROXY='https://proxy.golang.org,direct'
export GOSUMDB='sum.golang.org'

# Automatically download newer toolchains as directed by go.mod files.
# See https://go.dev/doc/toolchain for details.
export GOTOOLCHAIN=auto

# export PATH=$PATH:$GOROOT/bin:$GOPATH/bin:$GOROOT/packages/bin
export PATH=$PATH:'/home/lfccmbr/go/bin'
export GOPRIVATE="github.com/golang-cz"

source /usr/share/zsh/plugins/history-search-multi-word/history-search-multi-word.plugin.zsh

eval "$(direnv hook zsh)"

source $ZDOTDIR/git.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

. /opt/asdf-vm/asdf.sh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

eval "$(atuin init zsh)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/lfccmbr/google-cloud-sdk/path.zsh.inc' ]; then . '/home/lfccmbr/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/lfccmbr/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/lfccmbr/google-cloud-sdk/completion.zsh.inc'; fi

