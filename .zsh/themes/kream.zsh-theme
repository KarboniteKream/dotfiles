local ret_status="%(?:$:%{$fg_bold[red]%}$%{$reset_color%})"
PROMPT=$'%B%{$fg[green]%}%n@%m %{$fg[blue]%}%~%{$reset_color%}%b $(git_prompt_info)\n${ret_status} '
RPROMPT="%D{%H:%M:%S}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[yellow]%}✗"
