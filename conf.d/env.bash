# .rrc/conf.d/env.bash
#
# Couple of sets environment variables.

# English terminal output.
export LC_MESSAGES=C

# If exist, set Vim as default editor.
type vim &>/dev/null && export EDITOR='vim'

# If exist, set NeoVim as default editor.
type nvim &>/dev/null && export EDITOR='nvim'
