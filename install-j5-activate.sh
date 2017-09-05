#!/bin/bash

_this_script="`readlink -f "$BASH_SOURCE"`"
. "`dirname "$_this_script"`/helpers/include.sh"
. "$J5_ACTIVATE_HELPERS_DIR/colored-echo.sh"

bashrc_changed=
bashrc="$HOME/.bashrc"
bash_aliases_file="$J5_ACTIVATE_HELPERS_DIR/j5_bash_aliases.sh"
grep "^source '$bash_aliases_file'" "$bashrc" > /dev/null || {
    colored_echo blue "Setting up j5 bash aliases"
    echo "source '$bash_aliases_file'" >> "$bashrc"
    bashrc_changed=1
}
duplicate_check=`grep -c "j5_bash_aliases.sh" "$bashrc"`
[ "$duplicate_check" != "1" ] && colored_echo red "Check of $bashrc found $duplicate_check references to j5_bash_aliases.sh - should be 1. Check this file"
[ "$bashrc_changed" != "" ] && colored_echo blue "You will need to source .bashrc (restart bash) for new aliases"
[ "$duplicate_check" != "1" ] && exit 1

