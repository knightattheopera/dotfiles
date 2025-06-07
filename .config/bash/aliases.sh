#!/usr/bin/env bash

# ls aliases
alias ls="LC_COLLATE=C ls --color=auto --group-directories-first"

# scripts
alias youtube-to-mp3-playlist=~/.config/bash/scripts/youtube-to-mp3-playlist.sh
alias sync-home=~/.config/bash/scripts/sync-home.sh
alias sync-backups=~/.config/bash/scripts/sync-backups.sh
alias change-tex-snippets-directory=~/.config/bash/scripts/change-tex-snippets-directory.sh

# app shortcuts
function __custom_alias_run_zathura { apx run zathura "${1}" 2>/dev/null || zathura "${1}"; }
alias zth=__custom_alias_run_zathura 
function __custom_alias_run_vscode { apx run code "${1}" 2>/dev/null || code "${1}"; }
alias code=__custom_alias_run_vscode
alias wat2wasm=~/development/wabt/build/wat2wasm
alias cs=~/development/coursier/cs

# filesystem navigation
alias tree1="tree -L 1"
alias tree2="tree -L 2"

# dotfiles management
# see https://mitxela.com/projects/dotfiles_management
alias dotfiles="git --git-dir=$HOME/dotfiles --work-tree=$HOME"

