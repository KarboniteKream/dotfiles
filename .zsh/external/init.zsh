function __load_plugin() {
  local plugin_path="$ZSH/external/$1"

  if [[ -s "$plugin_path" ]]; then
    source "$plugin_path"
  else
    echo >&2 "Missing external plugin: ${1%%/*}"
  fi
}

__load_plugin "base16-shell/profile_helper.sh"
__load_plugin "zsh-autosuggestions/zsh-autosuggestions.zsh"
# Must be loaded last, to hook into all ZLE widgets.
__load_plugin "zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

unfunction __load_plugin
