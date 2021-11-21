#!/usr/bin/env bash
# $RRC_SRC_DIR/rrc_builtin/import/import.bash
#
# Name: rrc::import
#
# Part of rrc (https://github.com/rideee/rrc)
# Author: Michał Kątnik (https://github.com/rideee)
#
# This script allows import external files.

# Name with 'rrc::' prefix to avoid name conflicts.
scriptName='rrc::import'

# Exit error codes definition.
ERR_FILE_NOT_EXIST=1

# showHelp prints help message.
function showHelp() {
  cat <<EOF
Name: $scriptName
Author: Michał Kątnik (github.com/rideee)
Part of https://github.com/rideee/rrc, but can be used independent.

This script allows import external files to the script.
If the imported file does not exist, prints error message on stderr and exit
the script with non-zero value exit code.

It should be used inside some other script, it is useless when running directly
from the shell, but still is able to print this help message.

Usage directly in shell:
  $scriptName --help     # Prints this help message.

Usage inside the script:
  $scriptName IMPORTED_FILE...

  Example:
    If no errors, all IMPORTED_FILE(s) will be simply sourced to the script.
     $ $scriptName "../foo/bar.bash"

Exit codes meaning:
  $ERR_FILE_NOT_EXIST -> IMPORTED_FILE does not exist.
EOF
}

# printError prints formatted error message on stderr.
function printError() {
  [[ $RRC_DATE_FORMAT != "" ]] &&
    dateNow=$(date +"$RRC_DATE_FORMAT") ||
    dateNow=$(date -u)

  echo "ERROR [$dateNow] -> $scriptName:" "$@" >&2
}

# import tries to source provided external file. If this file not exist,
# prints error on stderr and exit.
# If arguments are not passed to the function, prints error on stderr and exit.
# Otherwise sources the file.
function import() {
  local file=$1

  # Test if file not exist.
  [[ ! -f $file ]] &&
    printError "Import failed. File: $file -> does not exist." &&
    exit $ERR_FILE_NOT_EXIST

  # If exist, sources it.
  # shellcheck source=/dev/null
  . "$file"
}

# Argument parser.
for arg in "$@"; do

  # If starts with '-'.
  if [[ $arg =~ ^- ]]; then
    # Check if --help, if yes shows help message and exit.
    [[ $arg == "--help" ]] && showHelp && exit
    # If not --help.
    continue
  fi

  # Everything else should be a file.
  import "$arg"

done
