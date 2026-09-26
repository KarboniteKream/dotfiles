autoload -Uz add-zle-hook-widget

# Reduce the key timeout after pressing Esc to 100 ms.
KEYTIMEOUT=10

# Print the Vi mode for the prompt.
function __vi_mode_prompt_info() {
  if [[ "$KEYMAP" == "vicmd" ]]; then
    print -n "%B%F{blue}<NORMAL>%f%b"
  fi
}

# Set the cursor style based on current Vi mode.
function __vi_mode_set_cursor() {
  if [[ "$KEYMAP" == "vicmd" ]]; then
    # Solid block.
    print -n $'\e[2 q'
  else
    # Thin line.
    print -n $'\e[6 q'
  fi
}

# Hook called whenever the active keymap changes.
function __vi_mode_keymap_select() {
  __vi_mode_set_cursor
  zle reset-prompt
}

# Hook called whenever Zsh is ready to accept user input.
function __vi_mode_line_init() {
  __vi_mode_set_cursor
}

# Hook called whenever we pass control back to Zsh.
function __vi_mode_line_finish() {
  # Reset the cursor style to default.
  print -n $'\e[0 q'
}

zle -N __vi_mode_keymap_select
zle -N __vi_mode_line_init
zle -N __vi_mode_line_finish

add-zle-hook-widget keymap-select __vi_mode_keymap_select
add-zle-hook-widget line-init __vi_mode_line_init
add-zle-hook-widget line-finish __vi_mode_line_finish

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
