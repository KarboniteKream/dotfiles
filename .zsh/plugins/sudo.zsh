# Toggle 'sudo' for the current (or previous) command.
function __sudo_command_line() {
  # Get the previous command, if the buffer is empty.
  if [[ -z "$BUFFER" ]]; then
    BUFFER="$(fc -ln -1)"
  fi

  # Preserve leading whitespace.
  local whitespace="${BUFFER%%[![:space:]]*}"
  BUFFER="${BUFFER#"$whitespace"}"

  if [[ "$BUFFER" == "sudo "* ]]; then
    BUFFER="${BUFFER#sudo }"
  else
    BUFFER="sudo $BUFFER"
  fi

  BUFFER="${whitespace}${BUFFER}"
  CURSOR="${#BUFFER}"
}

zle -N __sudo_command_line

# Bind to Alt+s.
__bindkey '\es' __sudo_command_line
