#!/bin/bash

# if we're being run, then refuse - this file is meant to be sourced
[ "$BASH_SOURCE" == "$0" ] && {
    echo This file must be used with "source $BASH_SOURCE" *from bash*. You cannot run it directly >&2
    exit 1
}

_this_script="`readlink -f "$BASH_SOURCE"`"
. "`dirname "$_this_script"`/include.sh"
. "$J5_ACTIVATE_HELPERS_DIR/colored-echo.sh"

j5activate() {
    if [ "$#" == 0 ]; then
        J5DIR=$J5_PARENT_GIT_DIR/j5-framework/j5/src/
    elif [ "${1#-}" != "$1" ]; then
        echo syntax j5activate "[framework-src-label]"
        return 1
    else
        J5DIR=$J5_PARENT_GIT_DIR/j5-framework-$1/j5/src/
        [ -d "$J5DIR" ] || { colored_echo red "Could not locate j5 framework - $J5DIR does not exist" >&2 ; return 1 ; }
    fi
    if [ -f "$J5DIR/Scripts/j5activate.sh" ]; then
        source "$J5DIR/Scripts/j5activate.sh"
    else
        J5VER=j5-$(grep "^version_code: " $J5DIR/j5-app.yml | sed 's/version_code: \(.*\)/\1/')
        J5_SERVICE_PACK=$(grep "^service_pack_code: " $J5DIR/j5-app.yml | sed 's/service_pack_code: \([0-9]+\).*$/\1/')
        [ "$J5_SERVICE_PACK" != "0" ] && J5VER="$J5VER.$J5_SERVICE_PACK"
        [ "$WORKON_HOME" == "" ] && WORKON_HOME="$HOME/.virtualenvs"
        if [ -d "$WORKON_HOME/$J5VER" ]; then
            colored_echo yellow "A virtual environment $J5VER seems to exist - will try workon $J5VER" >&2
            workon $J5VER
            colored_echo blue "Note that this is a version of j5 that does not support a full j5 environment" >&2
        else
            colored_echo red "The j5 framework version in $J5DIR does not support j5activate, and no legacy virtualenv was found" >&2
            return 1
        fi
    fi
}

