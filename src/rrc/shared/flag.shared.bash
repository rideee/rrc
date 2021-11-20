# Shared file - can be sourced from other scripts.
#
# Name: flag.shared.bash
# Author: Michał Kątnik (https://github.com/rideee)
#
# $RRC_DIR/src/rrc/shared/flag.shared.bash
# Part of rrc (https://github.com/rideee/rrc)
#
# Flag's parsing logic.
# -- Bash version 4 or higher required.
#

# Check if Bash version is less than 4, then inform and break the script.
[[ ${BASH_VERSION::1} > 4 ]] &&
  echo "$0: Required Bash version >= 4. Aborting..." >2 &&
  exit 100

# flag::flagsArray keeps all defined flags.
#flag::flagsArray=(Hello)
declare -a flagsArray=()

# flag::new creates new flag.
function flag::new() {
  # TODO: function flag::new not implement.
}

# TODO: Flag logic not implemented.
