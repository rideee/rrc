# .rrc/conf.d/alias.bash
#
# General aliases

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
[ "$(type tree 2>/dev/null)" ] && alias tree='tree -C'
[ "$(type tree 2>/dev/null)" ] && alias l='tree -L 1'

# Re-source .rrc/init.bash.
[ -f "$RRC_DIR/init.bash" ] && alias reload=". $RRC_DIR/init.bash"

# If EDITOR not empty, vi as an alias.
[ ! -z "$EDITOR" ] && alias vi='$EDITOR'
