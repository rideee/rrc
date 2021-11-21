# Shared file - can be sourced from other scripts.
#
# Name: bash-strict-mode.bash
# Author: Michał Kątnik (https://github.com/rideee)
#
# $RRC_SHARED_DIR/bash-strict-mode.bash
# Part of rrc (https://github.com/rideee/rrc)
#
# Use "Unofficial Bash Strict Mode" once this file has been sourced.

# Unofficial Bash Strict Mode.
# Read more:
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
# github.com/tests-always-included/wick/blob/master/doc/bash-strict-mode.md
# man set [or] set --help

# set -e -> Exit if a command exits with a non-zero status, unless that command
#   is part a test condition. On failure this triggers the ERR trap.
#
# set -E -> The ERR trap is inherited by shell functions, command substitutions
#   and commands in subshells. This helps us use wickStrictModeFail wherever
#   set -e is enabled.
#
# set -u -> Exit and trigger the ERR trap when accessing an unset variable.
#   This helps catch typos in variable names.
#
# set -o pipefail -> The return value of a pipeline is the status of the last
#   command to exit with a non-zero status, or zero if no command exited with
#   a non-zero status.
set -eEu -o pipefail

# shopt -s extdebug -> Enable extended debugging. Bash will track the parameters
#   to all of the functions in the call stack, allowing the stack trace to also
#   display the parameters that were used.
shopt -s extdebug

# IFS=$'\n\t' -> Set the "internal field separator", which is a list of
#   characters use for word splitting after expansion and to split lines into
#   words with the read builtin command.
#   Normally this is $' \t\n' and we're removing the space.
#   This helps us catch other issues when we may rely on IFS or accidentally
#   use it incorrectly.
IFS=$'\n\t'

# trap 'wickStrictModeFail $?' ERR -> The ERR trap is triggered when a script
#   catches an error. wickStrictModeFail attempts to produce a stack trace to
#   aid in debugging. We pass $? as the first argument so we have access to the
#   return code of the failed command.
trap 'wickStrictModeFail $?' ERR

export BASH_STRICT_MODE='true'
