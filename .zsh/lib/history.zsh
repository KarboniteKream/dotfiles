HISTFILE="$HOME/.zsh_history"
# Number of entries persisted to disk.
SAVEHIST=100000
# Number of entries to keep in memory.
HISTSIZE=100000

# Save timestamps and duration to the history file.
setopt extended_history
# Trim duplicate entries first when history file exceeds 'SAVEHIST' entries.
setopt hist_expire_dups_first

# Do not save consecutive duplicate commands.
setopt hist_ignore_dups
# Do not save commands starting with a leading space.
setopt hist_ignore_space

# Do not show duplicates when searching history.
setopt hist_find_no_dups
# When using history expansion, load the command without executing it.
setopt hist_verify

# Share history across sessions.
setopt share_history

# Print history entries with timestamps.
function history() {
  if [[ "$#" == "0" ]]; then
    builtin fc -i -l 1
  else
    builtin fc -i -l "$@"
  fi
}
