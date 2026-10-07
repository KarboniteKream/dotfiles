# --------------------------------------------------------------------------------------------------
# BOOTSTRAP ----------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------

typeset -g ZSH="$HOME/.zsh"

source "$ZSH/lib/env.zsh"
source "$ZSH/lib/functions.zsh"
source "$ZSH/lib/options.zsh"
source "$ZSH/lib/history.zsh"
source "$ZSH/lib/terminal.zsh"
source "$ZSH/lib/key-bindings.zsh"

# --------------------------------------------------------------------------------------------------
# PLUGINS & THEME ----------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------

source "$ZSH/plugins/fzf.zsh"
source "$ZSH/plugins/git.zsh"
source "$ZSH/plugins/man.zsh"
source "$ZSH/plugins/sudo.zsh"
source "$ZSH/plugins/vi-mode.zsh"

source "$ZSH/themes/kream.zsh"

# --------------------------------------------------------------------------------------------------
# COMPLETION & ALIASES -----------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------

source "$ZSH/lib/completion.zsh"
source "$ZSH/lib/aliases.zsh"

# --------------------------------------------------------------------------------------------------
# EXTERNAL -----------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------

function __load_plugin() {
  local plugin_path="$ZSH/external/$1"

  if [[ -s "$plugin_path" ]]; then
    source "$plugin_path"
    return 0
  else
    print -u2 "Missing external plugin: ${1%%/*}."
    return 1
  fi
}

__load_plugin "base16-shell/profile_helper.sh"
__load_plugin "zsh-autosuggestions/zsh-autosuggestions.zsh"
# Must be loaded last, to hook into all ZLE widgets.
__load_plugin "zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

unfunction __load_plugin
