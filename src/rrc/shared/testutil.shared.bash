# Shared file - can be sourced from other scripts.
#
# Name: testutil.shared.bash
# Author: Michał Kątnik (https://github.com/rideee)
#
# $RRC_DIR/src/rrc/shared/test.shared.bash
# Part of rrc (https://github.com/rideee/rrc)
#
# Useful tests definition.
#

# testutil::isRunningInteractively checks if script is running interactively.
# If is then return.
function testutil::isRunningInteractively() {
  [[ $- != *i* ]] && return
}
