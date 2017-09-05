#!/bin/bash

# if we're being run, then refuse - this file is meant to be sourced
[ "$BASH_SOURCE" == "$0" ] && {
    echo This file must be used with "source $BASH_SOURCE" *from bash*. You cannot run it directly >&2
    exit 1
}

_this_script="`readlink -f "$BASH_SOURCE"`"
. "`dirname "$_this_script"`"/include.sh

j5activate() {
    if [ "$#" == 0 ]; then
        J5DIR=$J5_PARENT_GIT_DIR/j5-framework/j5/src/
    elif [ "${1#-}" != "$1" ]; then
        echo syntax j5activate "[framework-src-label]"
    else
        J5DIR=$J5_PARENT_GIT_DIR/j5-framework-$1/j5/src/
    fi
    source "$J5DIR/Scripts/j5activate.sh"
}

