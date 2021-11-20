#################################################
#           RRC - Rid's Run Commands            #
#                                               #
#   Author: Michal Katnik (github.com/rideee)   #
#                                               #
#       Source this file to your .bashrc        #
#################################################

# If not running interactively, don't do anything.
[[ $- != *i* ]] && return

# Set required environment variables.
# RRC_DIR is a root directory.
export RRC_DIR=$(dirname ${BASH_SOURCE[0]})

# RRC_DIR related.
export RRC_BIN_DIR="$RRC_DIR/bin"
export RRC_COMPLETIONS_DIR="$RRC_DIR/completions"
export RRC_CONF_DIR="$RRC_DIR/conf.d"
export RRC_FUNC_DIR="$RRC_DIR/func.d"
export RRC_MAN_DIR="$RRC_DIR/man"
export RRC_USR_DIR="$RRC_DIR/usr.d"

# RRC_SRC_DIR related.
export RRC_SRC_DIR="$RRC_DIR/src"
export RRC_SHARED_DIR="$RRC_SRC_DIR/rrc/shared"

# Add bin dir to PATH.
[[ $(echo $PATH | grep "$RRC_BIN_DIR") ]] || export PATH="$PATH:$RRC_BIN_DIR"

# Import func files.
for f in $RRC_FUNC_DIR/*; do [[ -f $f ]] && . $f; done

# Import conf files.
for f in $RRC_CONF_DIR/*; do [[ -f $f ]] && . $f; done

# import custom user configuration files, best place for overriding defaults.
for f in $RRC_USR_DIR/*; do [[ -f $f ]] &&
  [[ $(basename $f) != 'README.md' ]] &&
  . $f; done

# Import completion files.
for f in $RRC_COMPLETIONS_DIR/*; do [[ -f $f ]] && . $f; done
