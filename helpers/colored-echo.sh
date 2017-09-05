
function colored_echo(){
    echo -n "`date '+%H:%M:%S'` "
    shift 1
    echo "$@"
}

which tput >/dev/null && function colored_echo(){
    tput setaf 7
    echo -n "`date '+%H:%M:%S'` "
    local color=$1
    shift 1
    if ! [[ $color =~ '^[0-9]$' ]] ; then
       case $(echo $color | tr '[:upper:]' '[:lower:]') in
        black) color=0 ;;
        red) color=1 ;;
        green) color=2 ;;
        yellow) color=3 ;;
        blue) color=4 ;;
        magenta) color=5 ;;
        cyan) color=6 ;;
        white|*) color=7 ;; # white or invalid color
       esac
    fi
    tput setaf $color
    echo "$@"
    tput sgr0
}

