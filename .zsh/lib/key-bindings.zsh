autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
autoload -Uz edit-command-line

# Bind a key to all used keymaps.
function __bindkey() {
  if [[ -z "$1" ]]; then
    return 0
  fi

  local km
  for km in "emacs" "vicmd" "viins"; do
    bindkey -M "$km" "$@"
  done
}

# Ensure that arrows and other special keys emit standard escape codes.
if [[ -n "${terminfo[smkx]}" && -n "${terminfo[rmkx]}" ]]; then
  autoload -Uz add-zle-hook-widget

  function __keypad_init() {
    print -rn -- "${terminfo[smkx]}"
  }

  function __keypad_finish() {
    print -rn -- "${terminfo[rmkx]}"
  }

  zle -N __keypad_init
  zle -N __keypad_finish

  add-zle-hook-widget line-init __keypad_init
  add-zle-hook-widget line-finish __keypad_finish
fi

# Activate Emacs mode.
bindkey -e

# Line navigation with Home/End.
__bindkey '^[[H' beginning-of-line
__bindkey '^[[F' end-of-line
__bindkey "${terminfo[khome]}" beginning-of-line
__bindkey "${terminfo[kend]}" end-of-line

# History navigation with Page{Up,Down}.
__bindkey "${terminfo[kpp]}" up-line-or-history
__bindkey "${terminfo[knp]}" down-line-or-history

# Word navigation with Ctrl+{Left,Right} and Alt+{b,f}.
__bindkey '^[[1;5D' backward-word
__bindkey '^[[1;5C' forward-word
__bindkey '\eb' backward-word
__bindkey '\ef' forward-word

# Character deletion with Backspace and Delete.
__bindkey '^?' backward-delete-char
__bindkey "${terminfo[kdch1]:-"^[[3~"}" delete-char

# Forward word deletion with Ctrl+Delete.
__bindkey '^[[3;5~' kill-word

# Cycle completion backwards with Shift+Tab.
__bindkey "${terminfo[kcbt]}" reverse-menu-complete

# Search through history.
__bindkey '^R' history-incremental-search-backward
__bindkey '^S' history-incremental-search-forward

# Search through history with current buffer prefix.
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

__bindkey '^[[A' up-line-or-beginning-search
__bindkey '^[[B' down-line-or-beginning-search
__bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
__bindkey "${terminfo[kcud1]}" down-line-or-beginning-search

# Use Alt+v to open the buffer in '$EDITOR'.
zle -N edit-command-line
__bindkey '\ev' edit-command-line
