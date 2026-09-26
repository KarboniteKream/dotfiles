# --------------------------------------------------------------------------------------------------
# BOOTSTRAP ----------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------

typeset -g ZSH="$HOME/.zsh"

typeset -g ZSH_CACHE_DIR="$ZSH/cache"
[[ -d "$ZSH_CACHE_DIR" ]] || mkdir -p "$ZSH_CACHE_DIR"
typeset -g SHORT_HOST="${SHORT_HOST:-${(%):-%m}}"

typeset -gU fpath
fpath=(
  "$ZSH/completions"
  "$ZSH_CACHE_DIR/completions"
  $fpath
)

source "$ZSH/lib/env.zsh"
source "$ZSH/lib/options.zsh"
source "$ZSH/lib/history.zsh"
source "$ZSH/lib/terminal.zsh"
source "$ZSH/lib/key-bindings.zsh"

# --------------------------------------------------------------------------------------------------
# PLUGINS & THEME ----------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------

source "$ZSH/plugins/git.zsh"
source "$ZSH/plugins/man.zsh"
source "$ZSH/plugins/sudo.zsh"
source "$ZSH/plugins/vi-mode.zsh"

source "$ZSH/themes/kream.zsh"

# --------------------------------------------------------------------------------------------------
# COMPLETION & ALIASES -----------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------

autoload -Uz compinit
compinit -i -d "$HOME/.zcompdump-$SHORT_HOST-$ZSH_VERSION"
source "$HOME/.oh-my-zsh/lib/completion.zsh"

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
    print -u2 "Missing external plugin: ${1%%/*}"
    return 1
  fi
}

__load_plugin "base16-shell/profile_helper.sh"
__load_plugin "zsh-autosuggestions/zsh-autosuggestions.zsh"
# Must be loaded last, to hook into all ZLE widgets.
__load_plugin "zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

unfunction __load_plugin
