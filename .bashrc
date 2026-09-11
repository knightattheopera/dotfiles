# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and grep
#
# might want to look into the `dircolors`
# command to enable better customization

alias ls='LC_COLLATE=C ls --color=auto --group-directories-first'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# XDG base directory specification,see
# https://specifications.freedesktop.org/basedir/latest/

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# alias definitions
[ -f "$HOME/.bash_aliases" ] && source "$HOME/.bash_aliases"

# set simple color prompt by default
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# attempt to set powerline prompt
if [ -f "$XDG_CONFIG_HOME/bash/prompt-powerline.sh" ] ; then
    source "$XDG_CONFIG_HOME/bash/prompt-powerline.sh"
fi

# setup scripts environment
[ -f "$HOME/scripts/env.sh" ] && source "$HOME/scripts/env.sh"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix ; then
    if [ -f /usr/share/bash-completion/bash_completion ] ; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ] ; then
        . /etc/bash_completion
    fi
fi
