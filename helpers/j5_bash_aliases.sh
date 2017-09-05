#!/bin/bash

# if we're being run, then refuse - this file is meant to be sourced
[ "$BASH_SOURCE" == "$0" ] && {
    echo This file must be used with "source $BASH_SOURCE" *from bash*. You cannot run it directly >&2
    exit 1
}

_j5_bash_aliases="`readlink -f "$BASH_SOURCE"`"
. "`dirname "$_j5_bash_aliases"`"/enable-j5-activate.sh

