# $RRC_DIR/conf.d/less-colors.bash
#
# Set colors for less manpager.

export LESS_TERMCAP_mb=$'\e[1;94m'
export LESS_TERMCAP_md=$'\e[1;94m'
export LESS_TERMCAP_me=$'\e[97m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[100;95m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;33m'

export MANPAGER='less -gi'
alias less='less -gi'
