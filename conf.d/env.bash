# $RRC_DIR/conf.d/env.bash
#
# Environment variables definitions.

# RRC_SRC_DIR stores path to src directory where are stored source files for
# scripts.
export RRC_SRC_DIR="$RRC_DIR/src"

# RRC_TEST_DIR stores path to 'test' directory, where test files are stored.
export RRC_TEST_DIR="$RRC_SRC_DIR/test"

# RRC_SHARED_DIR stores path to 'shared' directory, where shared files
# are stored, which are ready to be imported from other scripts.
export RRC_SHARED_DIR="$RRC_SRC_DIR/rrc_builtin/shared"

# RRC_MAN_DIR stores path to man directory.
export RRC_MAN_DIR="$RRC_DIR/man"

# RRC_VAR_DIR stores path to var directory, which can be used by scripts or
# functions to store additional data.
export RRC_VAR_DIR="$RRC_DIR/man"

# RRC_DATE_FORMAT sets default date format which can be used for e.g in logs.
export RRC_DATE_FORMAT="%d/%m/%Y %a %H:%M"

# LC_MESSAGES=C sets english terminal output.
export LC_MESSAGES=C

# If exists, set Vim as default editor.
type vim &>/dev/null && export EDITOR='vim'

# If exists, set NeoVim as default editor.
type nvim &>/dev/null && export EDITOR='nvim'
