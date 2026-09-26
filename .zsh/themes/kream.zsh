# <username>@<hostname> <directory> [git-branch] [git-dirty-state]
PROMPT=$'%B%F{green}%n@%m %F{blue}%~%f%b $(__git_prompt_info)\n%(?:$:%F{red}$%f) '
# [vim-mode]
RPROMPT=$'%{\e[1A%}$(__vi_mode_prompt_info)%{\e[1B%}'
