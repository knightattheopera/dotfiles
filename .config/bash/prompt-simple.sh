# Colors
GREEN="\[\e[01;32m\]"
DARKGREEN="\[\e[00;32m\]"
RESET="\[\e[00m\]"
BLUE="\[\e[01;34m\]"
DARKBLUE="\[\e[00;34m\]"
PURPLE="\[\e[01;35m\]"
# Colored Prompt
# Warning: this might not work if the terminal doesn't have color support. Simply comment the next line in that case
PS1="${debian_chroot:+($debian_chroot)}${PURPLE}\A${GREEN} [\h]${RESET} ${BLUE}\w${RESET} \$ "

