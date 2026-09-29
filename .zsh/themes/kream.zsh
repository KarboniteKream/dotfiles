function __kream_prompt_symbol() {
  if [[ "$KEYMAP" == "vicmd" ]]; then
    # Bold blue ':' on success, bold red ':' on error.
    print -n '%(?/%B%F{blue}:%f%b/%B%F{red}:%f%b)'
  else
    # Normal '$' on success, red '$' on error.
    print -n '%(?/$/%F{red}$%f)'
  fi
}

() {
  # <username>@<hostname> <directory> [git-branch] [git-dirty-state]
  local user_host='%B%F{green}%n@%m%f%b'
  local current_dir='%B%F{blue}%~%f%b'
  local git_info='$(__git_prompt_info)'
  local prompt_symbol='$(__kream_prompt_symbol)'

  PROMPT="$user_host $current_dir $git_info"$'\n'"$prompt_symbol "
}
