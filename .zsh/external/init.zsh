local -a plugins=(
  "base16-shell/profile_helper.sh"
  "zsh-autosuggestions/zsh-autosuggestions.zsh"
  # Must be loaded last, to hook into all ZLE widgets.
  "zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
)

local plugin plugin_path
for plugin in "${plugins[@]}"; do
  plugin_path="$ZSH/external/$plugin"

  if [[ -s "$plugin_path" ]]; then
    source "$plugin_path"
  else
    echo >&2 "[zsh] Missing external plugin: ${plugin%%/*}"
  fi
done
