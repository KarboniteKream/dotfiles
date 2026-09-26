# Enable advanced pattern matching.
setopt extended_glob
# Allow comments in interactive shells.
setopt interactive_comments
# Enable parameter expansion and command substitution in 'PROMPT' variables.
setopt prompt_subst
# Display additional information in background job status changes.
setopt long_list_jobs

# Automatically escape special characters when typing URLs.
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic
