# enable prompt colors: red prompt for root and green for users.
function ambientum_color_prompt()
{
  # B=bold
  local BOLD="\[\e[1m\]"
  # W=white
  local WHITE="\[\e[37m\]"
  # D=dim
  local DIM="\[\e[2m\]"
  # R=reset
  local RESET="\[\e[0;0;0m\]"

  # T=theme (default green)
  local THEME="\[\e[32m\]"
  # set T as red when root.
  if [ "$1" = root ]; then THEME="\[\e[31m\]"; fi

  # build PS1 variable parts.
  local PS1_USER="${BOLD}${DIM}${WHITE}u:${RESET}${BOLD}${WHITE}\u"
  local PS1_HOST="${BOLD}${DIM}${WHITE}h:${RESET}${BOLD}${THEME}\h"
  local PS1_CURD="${BOLD}${DIM}${WHITE}w:${RESET}${BOLD}${WHITE}\w"
  local PS1_SIGN="${BOLD}${THEME}\$"

  # set PS1
  export PS1="${RESET}${PS1_USER} ${PS1_HOST} ${PS1_CURD} ${PS1_SIGN} ${RESET}"
}

# call color prompt helper.
ambientum_color_prompt "$USER"

# unset previous function.
unset -f ambientum_color_prompt
