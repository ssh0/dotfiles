# A multiline prompt with username, hostname, full path, return status, git branch, git dirty status, git remote status

local return_status="%{$fg_bold[green]%}%(?..%{$fg_bold[red]%})>%{$reset_color%}"

local host_color="green"
if [ -n "$SSH_CLIENT" ]; then
  local host_color="red"
fi

PROMPT='%{$fg_bold[black]%}%{$bg[blue]%} %5c %{$reset_color%}$(git_prompt_info)$(git_remote_status)
 ${return_status} '


# RPROMPT='${return_status}%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}%{$bg[grey]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}%{$fg[grey]%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[grey]%} %{$fg_bold[yellow]%}⚡"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[grey]%}"
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE="%{$fg_bold[magenta]%}↓"
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE="%{$fg_bold[magenta]%}↑"
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE="%{$fg_bold[magenta]%}↕"
