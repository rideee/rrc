#################################################
#           RRC - Rid's Run Commands            #
#                                               #
#   Author: Michal Katnik (github.com/rideee)   #
#                                               #
#       Source this file to your .bashrc        #
#################################################

# If not running interactively, don't do anything.
[[ $- != *i* ]] && return

# RRC_DIR stores path to root rrc directory.
export RRC_DIR
RRC_DIR=$(dirname "${BASH_SOURCE[0]}")

# RRC_FUNC_DIR stores path to func.d drop-in directory.
export RRC_FUNC_DIR="$RRC_DIR/func.d"

# RRC_CONF_DIR stores path to conf.d drop-in directory.
export RRC_CONF_DIR="$RRC_DIR/conf.d"

# RRC_USR_DIR stores path to usr.d drop-in directory.
export RRC_USR_DIR="$RRC_DIR/usr.d"

# RRC_COMPLETION_DIR stores path to completion.d drop-in directory.
export RRC_COMPLETION_DIR="$RRC_DIR/completion.d"

# RRC_BIN_DIR stores path to bin directory.
export RRC_BIN_DIR="$RRC_DIR/bin"

# Add bin directory to PATH.
if echo "$PATH" | grep -q "$RRC_BIN_DIR"; then
  export PATH="$PATH:$RRC_BIN_DIR"
fi

# Import function files.
# shellcheck source=/dev/null
for f in "$RRC_FUNC_DIR"/*; do [[ -f $f ]] && . "$f"; done

# Import confg files.
# shellcheck source=/dev/null
for f in "$RRC_CONF_DIR"/*; do [[ -f $f ]] && . "$f"; done

# Import custom users config files.
# The best place for overwriting defaults.
# shellcheck source=/dev/null
for f in "$RRC_USR_DIR"/*; do [[ -f $f ]] &&
  [[ $(basename "$f") != 'README.md' ]] &&
  . "$f"; done

# Import completion files.
# shellcheck source=/dev/null
for f in "$RRC_COMPLETION_DIR"/*; do [[ -f $f ]] && . "$f"; done
