# Helper functions

_include_script="`readlink -f "$BASH_SOURCE"`"
J5_ACTIVATE_HELPERS_DIR="`dirname "$_include_script"`"
J5_ACTIVATE_DIR="`dirname "$J5_ACTIVATE_HELPERS_DIR"`"
J5_ACTIVATE_BIN_DIR="$J5_ACTIVATE_DIR/bin"
J5_PARENT_GIT_DIR="`dirname "$J5_ACTIVATE_DIR"`"

