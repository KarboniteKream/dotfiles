autoload -Uz add-zle-hook-widget

# Reduce the key timeout after pressing Esc to 100 ms.
KEYTIMEOUT="10"

# Print the Vi mode for the prompt.
function __vi_mode_prompt_info() {
  if [[ "$KEYMAP" == "vicmd" ]]; then
    print -n "%B%F{blue}<NORMAL>%f%b"
  fi
}

# Hook called whenever the active keymap changes.
function __vi_mode_keymap_select() {
  # Redraw the prompt, to show the Vi mode.
  zle reset-prompt
}

zle -N __vi_mode_keymap_select

add-zle-hook-widget keymap-select __vi_mode_keymap_select

# Activate Vi mode.
bindkey -v

# Restore convenient shortcuts from Emacs.
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^E' end-of-line
bindkey -M viins '^W' backward-kill-word
bindkey -M viins '^U' kill-whole-line
bindkey -M viins '^P' up-history
bindkey -M viins '^N' down-history

# Use non-beeping Emacs movement.
bindkey -M vicmd '^[[D' backward-char
bindkey -M vicmd '^[OD' backward-char
bindkey -M vicmd '^[[C' forward-char
bindkey -M vicmd '^[OC' forward-char
bindkey -M viins '^[[D' backward-char
bindkey -M viins '^[OD' backward-char
bindkey -M viins '^[[C' forward-char
bindkey -M viins '^[OC' forward-char
