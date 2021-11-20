#!/usr/bin/env bash
#
# Name: srcgen
# Part of rrc (https://github.com/rideee/rrc)
#
# This is a simple script generator.
#
# https://github.com/rideee/rrc/src/rrc/scrgen
# See the README.md file for more information.
#
# Author: Michał Kątnik (https://github.com/rideee)
#

# Use Unofficial Bash Strict Mode.
# Read more:
# https://gist.github.com/robin-a-meade/58d60124b88b60816e8349d1e3938615
set -e              # Set the errexit option
set -o errexit      # Equivalent
shopt -s -o errexit # Equivalent (TMTOWTDI FTW!)

set +e              # Unset the errexit option
set +o errexit      # Equivalent
shopt -u -o errexit # Equivalent

# Declare script related variables.
SCRIPT_NAME=$(basename $0)
SCRIPT_PATH=$(dirname $0)

echo name $scriptName
echo path $scriptPath

# for testing only...
rrc::import "$SCRIPT_PATH/test/scrgen_test.bash"
rrc::import "$RRC_SRC_DIR/rrc/scrgen/test/scrgen_test.bash"

# TODO: implement the script.
