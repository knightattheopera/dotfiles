#!/usr/bin/env bash

# ls aliases
alias ls="LC_COLLATE=C ls --color=auto --group-directories-first"

# app shortcuts
function __custom_alias_run_zathura { apx run zathura "${1}" 2>/dev/null || zathura "${1}"; }
alias zth=__custom_alias_run_zathura 
function __custom_alias_run_vscode { apx run code "${1}" 2>/dev/null || code "${1}"; }
alias code=__custom_alias_run_vscode
alias wat2wasm=~/external-repos/wabt/build/wat2wasm

# filesystem navigation
alias tree1="tree -L 1"
alias tree2="tree -L 2"


