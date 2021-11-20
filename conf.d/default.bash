# $RRC_DIR/conf.d/default.bash
#
# Default config file.

# Set the bash prompt command.
PROMPT_COMMAND='rrc::ps1'

# Set case insensitive completion.
bind 'set completion-ignore-case on'

# Unbind CTRL-S which pauses all command output to the screen.
bind -r '\C-s'

# Set tab completion mode.
bind 'TAB:complete'
