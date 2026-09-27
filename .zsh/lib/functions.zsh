# Ensure that the required commands exist in PATH.
function __require_cmd() {
  local -a missing=()
  local cmd

  for cmd in "$@"; do
    if [[ -z "${commands[$cmd]}" ]]; then
      missing+=("$cmd")
    fi
  done

  if [[ ${#missing} -gt 0 ]]; then
    print -u2 "Missing required commands: ${(j:, :)missing}"
    return 1
  fi
}

# Bind a key to all relevant keymaps.
function __bind_key() {
  if [[ -z "$1" ]]; then
    return 0
  fi

  local km
  for km in "emacs" "vicmd" "viins"; do
    bindkey -M "$km" "$@"
  done
}
