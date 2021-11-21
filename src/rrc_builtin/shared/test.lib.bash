# $RRC_SHARED_DIR/test.lib.bash
#
# Part of rrc (https://github.com/rideee/rrc)
#
# Shared file - can be sourced from other scripts.
# Author: Michał Kątnik (https://github.com/rideee)
#
# Provides reusable state conditions tests.

# test::isInteractive() checks if script is running interactively.
# If is, then returns true, otherwise false.
function test::isInteractive() {
  [[ $- == *i* ]] && return
}
