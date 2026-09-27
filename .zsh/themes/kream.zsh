() {
  # <username>@<hostname> <directory> [git-branch] [git-dirty-state]
  local user_host='%B%F{green}%n@%m%f%b'
  local current_dir='%B%F{blue}%~%f%b'
  local git_info='$(__git_prompt_info)'
  # OSC 133 secondary prompt mark for terminal integration.
  local osc_mark=$'%{\e]133;A;k=s\a%}'
  local prompt_symbol='%(?:$:%F{red}$%f)'

  PROMPT="$user_host $current_dir $git_info"$'\n'"$osc_mark$prompt_symbol "

  # [vi-mode]
  local move_up=$'%{\e[1A%}'
  local vi_mode='$(__vi_mode_prompt_info)'
  local move_down=$'%{\e[1B%}'

  RPROMPT="$move_up$vi_mode$move_down"
}
