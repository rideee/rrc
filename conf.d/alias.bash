# $RRC_DIR/conf.d/alias.bash
#
# General aliases definitions.

alias ':q'='exit'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias hg='history | grep'

alias ls='ls --color=auto'
alias l='ls -1'
alias ll='ls -ltrh'
alias la='ls -ltrAh'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# If tree in PATH.
[[ $(type tree 2>/dev/null) ]] && alias tree='tree -C' && alias l='tree -L 1'

# Re-source $RRC_DIR/init.bash.
[[ -f "$RRC_DIR/init.bash" ]] && alias reload='. $RRC_DIR/init.bash'

# vi as an alias to the default editor.
alias vi='$EDITOR'
