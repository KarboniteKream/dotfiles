export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export PATH="$HOME/.bin:$HOME/.cargo/bin:/opt/homebrew/opt/ruby/bin:/opt/homebrew/sbin:$PATH"
export EDITOR="vim"

export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_DEFAULT_OPTS="
    --inline-info --height=16 --reverse
    --color=bg+:#2c2421,bg:#1b1918,spinner:#3d97b8,hl:#407ee7
    --color=fg:#9c9491,header:#407ee7,info:#c38418,pointer:#3d97b8
    --color=marker:#3d97b8,fg+:#e6e2e0,prompt:#c38418,hl+:#407ee7
"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100'"

export SPRING_OUTPUT_ANSI_ENABLED="ALWAYS"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home"

# https://github.com/testcontainers/testcontainers-dotnet/pull/1235
export DOCKER_HOST="unix://$HOME/.colima/docker.sock"
export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE=/var/run/docker.sock

eval "$(/opt/homebrew/bin/brew shellenv)"
