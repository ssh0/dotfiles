# vim:ft=zsh ts=2 sw=2 sts=2
#=#=#=
# simle_is_power theme  
# folked from agnoster's Theme - https://gist.github.com/3712874
#
# In order for this theme to render correctly, you will need a
# [Powerline-patched font](https://github.com/Lokaltog/powerline-fonts).
#=#=
#==============================================================================
# Color setting                                                             {{{
#==============================================================================

setopt prompt_subst

# Flexoki Light palette
# Source: /Users/fujimotoshotaro/src/flexoki/css/flexoki.css
flexoki_black='#100F0F'
flexoki_paper='#FFFCF0'
flexoki_100='#E6E4D9'
flexoki_200='#CECDC3'
flexoki_red='#D14D41'
flexoki_yellow='#D0A215'
flexoki_green='#879A39'
flexoki_cyan='#3AA99F'
flexoki_blue='#4385BE'


flexoki_base_950='#1c1b1a'
flexoki_base_900='#282726'
flexoki_base_850='#343331'
flexoki_base_800='#403e3c'
flexoki_base_700='#575653'
flexoki_base_600='#6f6e69'
flexoki_base_500='#878580'
flexoki_base_300='#b7b5ac'
flexoki_base_200='#cecdc3'
flexoki_base_150='#dad8ce'
flexoki_base_100='#e6e4d9'
flexoki_base_50='#f2f0e5'
flexoki_paper='#fffcf0'


bg_dir=${flexoki_base_150}
bg_dark=${flexoki_base_50}
fg_red=${flexoki_red}
fg_main=${flexoki_black}

#===========================================================================}}}
# Segment drawing                                                           {{{
#==============================================================================
# A few utility functions to make it easy and re-usable to draw segmented prompts

CURRENT_BG='NONE'
# SEGMENT_SEPARATOR=''
SEGMENT_SEPARATOR=''
# SEGMENT_SEPARATOR=''
# SEGMENT_SEPARATOR='▒'
# SEGMENT_SEPARATOR='▓▒░'

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

#===========================================================================}}}
# Prompt components                                                         {{{
#==============================================================================
# Each component will draw itself, and hide itself if no information needs to be shown
#------------------------------------------------------------------------------
# Init:                                                                     {{{
#------------------------------------------------------------------------------

prompt_init() {
  echo -n "%{%F{${bg_dir}}%K{${bg_dir}}%}#"
}

#---------------------------------------------------------------------------}}}
# Status:                                                                   {{{
#------------------------------------------------------------------------------
# - was there an error
# - am I root
# - are there background jobs?
# - am I in ranger subshell?

prompt_status() {
  local symbols
  symbols=()
  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{${fg_red}}%}✞"
  [[ $UID -eq 0 ]] && symbols+="%{%F{${flexoki_yellow}}%}⚡"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{${flexoki_cyan}}%}⚙"
  [[ -n ${RANGER_LEVEL} ]] && symbols+="%{%F{${flexoki_blue}}%}®"

  [[ -n "$symbols" ]] && prompt_segment ${bg_dark} NONE "$symbols"
}

#---------------------------------------------------------------------------}}}
# Virtualenv: current working virtualenv                                    {{{
#------------------------------------------------------------------------------

prompt_virtualenv() {
  local virtualenv_path="$VIRTUAL_ENV"
  if [[ -n $virtualenv_path && -n $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
    prompt_segment ${flexoki_green} ${flexoki_black} "(`basename $virtualenv_path`)"
  fi
}

#---------------------------------------------------------------------------}}}
# Dir: current working directory                                            {{{
#------------------------------------------------------------------------------

prompt_dir() {
  prompt_segment ${bg_dir} ${fg_main} '%~'
}

#---------------------------------------------------------------------------}}}
# Git: branch/detached head, dirty status                                   {{{
#------------------------------------------------------------------------------

prompt_git() {
  local ref dirty mode repo_path
  repo_path=$(git rev-parse --git-dir 2>/dev/null)

  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    # dirty=$(parse_git_dirty)
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➔ $(git show-ref --head -s --abbrev |head -n1 2> /dev/null)"
    # if [[ -n $dirty ]]; then
      # prompt_segment ${bg_dark} 223
    # else
      prompt_segment ${bg_dark} ${flexoki_cyan}
    # fi

    if [[ -e "${repo_path}/BISECT_LOG" ]]; then
      mode=" <B>"
    elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
      mode=" >M<"
    elif [[ -e "${repo_path}/rebase" || -e "${repo_path}/rebase-apply" || -e "${repo_path}/rebase-merge" || -e "${repo_path}/../.dotest" ]]; then
      mode=" >R>"
    fi

    autoload -Uz vcs_info

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' get-revision true
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' stagedstr '+'
    zstyle ':vcs_info:git:*' unstagedstr '*'
    zstyle ':vcs_info:*' formats ' %u%c'
    zstyle ':vcs_info:*' actionformats ' %u%c'
    vcs_info
    echo -n "${ref/refs\/heads\// }${vcs_info_msg_0_%% }${mode}"
  fi
}

#---------------------------------------------------------------------------}}}
# Hg: prompt                                                                {{{
#------------------------------------------------------------------------------

prompt_hg() {
  local rev status
  if $(hg id >/dev/null 2>&1); then
    if $(hg prompt >/dev/null 2>&1); then
      if [[ $(hg prompt "{status|unknown}") = "?" ]]; then
        # if files are not added
        prompt_segment ${fg_red} ${bg_dark}
        st='±'
      elif [[ -n $(hg prompt "{status|modified}") ]]; then
        # if any modification
        prompt_segment ${flexoki_yellow} ${bg_dark}
        st='±'
      else
        # if working copy is clean
        prompt_segment ${flexoki_cyan} ${bg_dark}
      fi
      echo -n $(hg prompt "☿ {rev}@{branch}") $st
    else
      st=""
      rev=$(hg id -n 2>/dev/null | sed 's/[^-0-9]//g')
      branch=$(hg id -b 2>/dev/null)
      if `hg st | grep -q "^\?"`; then
        prompt_segment ${fg_red} ${bg_dark}
        st='±'
      elif `hg st | grep -q "^(M|A)"`; then
        prompt_segment ${flexoki_yellow} ${bg_dark}
        st='±'
      else
        prompt_segment ${flexoki_cyan} ${bg_dark}
      fi
      echo -n "☿ $rev@$branch" $st
    fi
  fi
}

#}}}========================================================================}}}
# Build main prompt                                                         {{{
#==============================================================================

build_prompt() {
  RETVAL=$?
  prompt_init
  prompt_virtualenv
  prompt_dir
  prompt_git
  prompt_hg
  prompt_status
  prompt_end
}

PROMPT='%{%f%b%k%}$(build_prompt)%{$reset_color%}
%{%F{${bg_dir}}%}\$ %{$reset_color%}'
RPROMPT=''

PROMPT2='%{%F{${flexoki_cyan}}%}↪%{$reset_color%} '
RPROMPT2='%{%F{${flexoki_green}}%}%_%{$reset_color%}'

#===========================================================================}}}
