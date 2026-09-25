# Terminal capability color overrides.
typeset -AHg __less_termcap
__less_termcap[mb]=$'\e[1;31m'    # Mode blinking: Red.
__less_termcap[md]=$'\e[1;31m'    # Mode double-bright: Red.
__less_termcap[me]=$'\e[0m'       # Mode end: Reset.
__less_termcap[so]=$'\e[1;30;43m' # Standout: Bold black on yellow.
__less_termcap[se]=$'\e[0m'       # Standout end: Reset.
__less_termcap[us]=$'\e[1;32m'    # Underline: Green.
__less_termcap[ue]=$'\e[0m'       # Underline end: Reset.

function man() {
  local -a environment

  # Use 'less' as the pager, if possible.
  environment+=("PAGER=${commands[less]:-"$PAGER"}")
  # Disable modern Groff SGR escapes, so LESS_TERMCAP can be used.
  environment+=("GROFF_NO_SGR=1")

  local k v
  for k v in "${(@kv)__less_termcap}"; do
    environment+=("LESS_TERMCAP_$k=$v")
  done

  command env "${environment[@]}" man "$@"
}
