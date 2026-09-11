# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# XDG base directory specification,see
# https://specifications.freedesktop.org/basedir/latest/

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# if running bash
if [ -n "$BASH_VERSION" ] ; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ] ; then
        . "$HOME/.bashrc"
    fi
fi

echo "Reading .profile"

# Setup coursier
if [ -d "$HOME:/.local/share/coursier/bin" ] ; then
    export PATH="$PATH:$HOME/.local/share/coursier/bin"
    # >>> JVM installed by coursier >>>
    export JAVA_HOME="$HOME/.cache/coursier/arc/https/github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.10%252B7/OpenJDK17U-jdk_x64_linux_hotspot_17.0.10_7.tar.gz/jdk-17.0.10+7"
    export PATH="$PATH:$HOME/.cache/coursier/arc/https/github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.10%252B7/OpenJDK17U-jdk_x64_linux_hotspot_17.0.10_7.tar.gz/jdk-17.0.10+7/bin"
    # <<< JVM installed by coursier <<<
fi

# Setup flutter
if [ -d "$HOME/development/flutter/bin" ] ; then
    export PATH="$HOME/development/flutter/bin:$PATH"
fi

# Setup nvm
if [ -d "$HOME/.nvm" ] ; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

# Setup ruby gems
if [ -d "$HOME/development/gems" ] ; then
    export GEM_HOME="$HOME/development/gems"
    export PATH="$HOME/development/gems/bin:$PATH"
fi

# Setup miniconda
if [ -d "$HOME/development/miniconda3/bin" ] ; then
    export PATH="$HOME/development/miniconda3/bin:$PATH"
    eval "$('conda' 'shell.bash' 'hook')"
fi

# Setup Cangjie
if [ -f "$HOME/development/cangjie/1.0.0/envsetup.sh" ] ; then
    . "$HOME/development/cangjie/1.0.0/envsetup.sh"
fi

# Setup Swift
if [ -f "$HOME/.local/share/swiftly/env.sh" ] ; then
    . "$HOME/.local/share/swiftly/env.sh"
fi

# Setup go
if [ -d "$HOME/development/go/bin" ] ; then
    export PATH="$HOME/development/go/bin:$PATH"
fi

# Setup opam
test -r $HOME/.opam/opam-init/init.sh && . $HOME/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

