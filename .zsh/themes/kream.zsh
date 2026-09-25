local ret_status='%(?:$:%F{red}$%f)'
PROMPT=$'%B%F{green}%n@%m %F{blue}%~%f%b $(__git_prompt_info)\n$ret_status '
