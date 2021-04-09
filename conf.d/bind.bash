# .rrc/conf.d/bind.bash
#
# Binding setting file.

# Case insensitive completion.
bind 'set completion-ignore-case on'

# Unbind CTRL-S.
bind -r '\C-s'

# bind 'set show-all-if-ambiguous on'
bind 'TAB:complete' # || bind 'TAB:menu-complete'
