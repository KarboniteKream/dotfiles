export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export PATH="$HOME/.bin:$HOME/.cargo/bin:/opt/homebrew/opt/ruby/bin:/opt/homebrew/sbin:$PATH"

export SPRING_OUTPUT_ANSI_ENABLED="ALWAYS"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home"

# https://github.com/testcontainers/testcontainers-dotnet/pull/1235
export DOCKER_HOST="unix://$HOME/.colima/docker.sock"
export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE=/var/run/docker.sock

eval "$(/opt/homebrew/bin/brew shellenv)"
