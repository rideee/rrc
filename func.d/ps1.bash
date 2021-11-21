# $RRC_DIR/func.d/ps1.bash
#
# This function sets $PS1 environment variable.

function rrc::ps1() {
  local ps1_errCode="$?"

  local ps1_exitCode="\[\033[38;5;2m\]√\[$(tput sgr0)\]" # Exit code 0 arrow
  [ "$ps1_errCode" != 0 ] &&
    ps1_exitCode="\[\033[38;5;1m\]ε:${ps1_errCode}\[$(tput sgr0)\]" # Exit code !0 arrow

  local ps1_gitArrow="\[\033[38;5;86m\]↳\[$(tput sgr0)\]"
  local ps1_separator="\[\033[38;5;4m\]@\[$(tput sgr0)\]"
  local ps1_usr="\[\033[38;5;12m\]\u\[$(tput sgr0)\]"
  local ps1_host="\[\033[38;5;12m\]\h\[$(tput sgr0)\]"
  local ps1_path="\[\033[38;5;11m\]\w\[$(tput sgr0)\]"
  local ps1_dirname="\[\033[38;5;11m\]\W\[$(tput sgr0)\]"
  local ps1_promChar="\[$(tput bold)\]\[\033[38;5;12m\]\$\[$(tput sgr0)\]"

  # Check if root.
  if [ "$EUID" -eq 0 ]; then
    ps1_usr="\[$(tput bold)\]\[\033[38;5;9m\]\u\[$(tput sgr0)\]"
    ps1_promChar="\[$(tput bold)\]\[\033[38;5;9m\]\$\[$(tput sgr0)\]"
  fi

  local ps1_usr_host="${ps1_usr}${ps1_separator}${ps1_host}"

  # If git in PATH.
  if [ "$(type git 2>/dev/null)" ]; then
    local ps1_gitBranch=$(git branch 2>/dev/null |
      sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')

    if [ $ps1_gitBranch ]; then
      local ps1_git=" \[\033[38;5;4m\][\[$(tput sgr0)\]\[\033[38;5;86m\]"
      ps1_git+="$ps1_gitArrow "
      ps1_git+="\[$(tput sgr0)\]\[\033[38;5;120m\]"
      ps1_git+="$ps1_gitBranch"
      ps1_git+="\[\033[38;5;4m\]]\[$(tput sgr0)\]\[\033[38;5;86m\]"
    fi
  fi

  # TODO: Implement themes.
  # If $1 == simplify then remove user and hostname.
  [[ $1 == 'simplify' ]] &&
    export PS1="${ps1_exitCode}${ps1_git} ${ps1_dirname} ${ps1_promChar} " ||
    export PS1="${ps1_exitCode}${ps1_git} ${ps1_usr_host} ${ps1_path} ${ps1_promChar} "
}
