autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
autoload -Uz edit-command-line

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

# Match Vim behavior for word boundaries.
WORDCHARS='*?_.[]~=&;!#$%^(){}<>'

# Line navigation with Home/End.
__bind_key '^[[H' beginning-of-line
__bind_key '^[[F' end-of-line
__bind_key "${terminfo[khome]}" beginning-of-line
__bind_key "${terminfo[kend]}" end-of-line

# History navigation with Page{Up,Down}.
__bind_key "${terminfo[kpp]}" up-line-or-history
__bind_key "${terminfo[knp]}" down-line-or-history

# Word navigation with Ctrl+{Left,Right} and Alt+{B,F}.
__bind_key '^[[1;5D' backward-word
__bind_key '^[[1;5C' forward-word
__bind_key '\eb' backward-word
__bind_key '\ef' forward-word

# Character deletion with Backspace and Delete.
__bind_key '^?' backward-delete-char
__bind_key "${terminfo[kdch1]:-"^[[3~"}" delete-char

# Forward word deletion with Ctrl+Delete.
__bind_key '^[[3;5~' kill-word

# Cycle completion backwards with Shift+Tab.
__bind_key "${terminfo[kcbt]}" reverse-menu-complete

# Search through history.
__bind_key '^R' history-incremental-search-backward
__bind_key '^S' history-incremental-search-forward

# Search through history with current buffer prefix.
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

__bind_key '^[[A' up-line-or-beginning-search
__bind_key '^[[B' down-line-or-beginning-search
__bind_key "${terminfo[kcuu1]}" up-line-or-beginning-search
__bind_key "${terminfo[kcud1]}" down-line-or-beginning-search

# Use Alt+v to open the buffer in '$EDITOR'.
zle -N edit-command-line
__bind_key '\ev' edit-command-line
