zmodload -i zsh/complist
autoload -Uz compinit

typeset -g ZSH_CACHE="$ZSH/cache"
typeset -g ZSH_COMPDUMP="$ZSH_CACHE/zcompdump-$ZSH_VERSION"

if [[ ! -d "$ZSH_CACHE/zcompcache" ]]; then
  mkdir -p "$ZSH_CACHE"/{completions,zcompcache}
fi

# Add completions to the function search path.
typeset -gU fpath=(
  "$ZSH/completions"
  "$ZSH_CACHE/completions"
  $fpath
)

# Commands with slow lookups during completion.
typeset -ga ZSH_SLOW_COMMANDS=(
  "ansible" "terraform" "tofu" "vagrant"
  "rsync" "scp" "sftp" "ssh"
  "apt" "brew" "dnf" "pacman"
  "argocd" "helm" "kubectl"
  "docker" "podman"
  "gh"
)

# Rebuild and recompile the completion dump file.
function compreset() {
  local -aU insecure=(${(f)"$(compaudit 2>/dev/null)"})
  if [[ "${#insecure}" -gt 0 ]]; then
    print -u2 "Insecure completion directories detected, see 'compaudit'."
  fi

  command rm -f "$ZSH_COMPDUMP"{,.zwc}
  compinit -i -d "$ZSH_COMPDUMP"
  zcompile "$ZSH_COMPDUMP"
}

# Display yellow ellipsis when waiting for slow completions.
function __expand_or_complete() {
  local -a words=(${${(z)BUFFER}:#*=*})

  # Skip over 'sudo' and its arguments.
  if [[ "$words[1]" == "sudo" ]]; then
    shift words

    while [[ "$words[1]" == "-"* ]]; do
      shift words
    done
  fi

  # Resolve any aliases.
  local cmd="${words[1]:t}"
  local -a alias_words=(${(z)aliases[$cmd]})
  cmd="${alias_words[1]:-$cmd}"

  if [[ "${ZSH_SLOW_COMMANDS[(I)$cmd]}" -gt 0 ]]; then
    print -Pn '\e[?7l%F{yellow}…%f\e[?7h'
    zle expand-or-complete
    zle redisplay
  else
    zle expand-or-complete
  fi
}

# Do not auto-insert the first match on first Tab.
unsetopt menu_complete
# Disable terminal flow control with Ctrl+S and Ctrl+Q.
unsetopt flow_control
# Show an interactive menu on successive Tab presses.
setopt auto_menu
# Allow completion at the cursor in the middle of a word.
setopt complete_in_word
# Move cursor to the end of the word after accepting a completion.
setopt always_to_end

# Cache expensive lookups on disk.
zstyle ":completion:*" use-cache true
zstyle ":completion:*" cache-path "$ZSH_CACHE/zcompcache"

# Automatically rehash commands on completion.
zstyle ":completion:*" rehash true

# Enable navigation with arrow keys.
zstyle ":completion:*" menu select

# Configure case-sensitive word and substring completion.
zstyle ":completion:*" matcher-list "r:|=*" "l:|=* r:|=*"

# Prioritize local directories before directory stack history.
zstyle ":completion:*:cd:*" tag-order local-directories directory-stack path-directories
# Disable category headers.
zstyle ":completion:*:cd:*:descriptions" format ""

# Colorize completion items.
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"

# Group the matches into categories.
zstyle ":completion:*:descriptions" format '%F{blue}-- %d --%f'
zstyle ":completion:*:messages" format '%F{yellow}-- %d --%f'
zstyle ":completion:*" group-name ""
zstyle ":completion:*" verbose true

# Improve display of completions for 'kill'.
zstyle ":completion:*:processes" command "ps -U $USER -o pid,command -w -w"
zstyle ":completion:*:*:kill:*:processes" list-colors '=(#b) #([0-9]#)*=0=01;34'

# Cycle backwards with Shift+Tab and accept next match with Ctrl+O..
bindkey -M menuselect "${terminfo[kcbt]:-"^[[Z"}" reverse-menu-complete
bindkey -M menuselect '^o' accept-and-infer-next-history

zle -N __expand_or_complete
bindkey -M emacs '^I' __expand_or_complete
bindkey -M viins '^I' __expand_or_complete

# Rebuild the dump file every 24 hours.
if [[ -n "$ZSH_COMPDUMP"(#qN.mh-24) ]]; then
  compinit -C -d "$ZSH_COMPDUMP"
else
  compreset
fi
