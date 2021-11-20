# .rrc/conf.d/env.bash
#
# Couple of sets environment variables.

# Other, less critical, RRC_* definitions.
# RRC_DATE_FORMAT is the default date format which is used e.g during err logs.
export RRC_DATE_FORMAT="%d/%m/%Y %a %H:%M"

# English terminal output.
export LC_MESSAGES=C

# If exist, set Vim as default editor.
type vim &>/dev/null && export EDITOR='vim'

# If exist, set NeoVim as default editor.
type nvim &>/dev/null && export EDITOR='nvim'
