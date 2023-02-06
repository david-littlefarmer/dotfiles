autoload -Uz vcs_info
autoload -U colors && colors
setopt promptsubst

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '!'
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:*' formats "%b%c%u"
precmd () {
  vcs_info

  STATUS=$(command git status --porcelain 2> /dev/null | tail -n1)
  git status 2>/dev/null 1>&2
  if [ $? -eq 0 ]; then
    if [ -z $STATUS ]; then
      local git_branch='%F{green} {$vcs_info_msg_0_'}
    else
      local git_branch='%F{blue} {$vcs_info_msg_0_'}
    fi
  fi
  PROMPT="%F{green}% %Blf%F{blue}%\:%F{red}%~%b${git_branch}%F{yellow}% $ %F{white}% %b"
}

