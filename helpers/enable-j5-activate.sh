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
        return 1
    else
        J5DIR=$J5_PARENT_GIT_DIR/j5-framework-$1/j5/src/
        [ -d "$J5DIR" ] || { echo Could not locate j5 framework - $J5DIR does not exist >&2 ; return 1 ; }
    fi
    [ -f "$J5DIR/Scripts/j5activate.sh" ] || { echo The j5 framework version in $J5DIR does not support j5activate >&2 ; return 1 ; }
    source "$J5DIR/Scripts/j5activate.sh"
}

