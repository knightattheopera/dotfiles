# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi


echo "Reading .profile"

# >>> JVM installed by coursier >>>
export JAVA_HOME="$HOME/.cache/coursier/arc/https/github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.10%252B7/OpenJDK17U-jdk_x64_linux_hotspot_17.0.10_7.tar.gz/jdk-17.0.10+7"
export PATH="$PATH:$HOME/.cache/coursier/arc/https/github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.10%252B7/OpenJDK17U-jdk_x64_linux_hotspot_17.0.10_7.tar.gz/jdk-17.0.10+7/bin"
# <<< JVM installed by coursier <<<

# >>> coursier install directory >>>
export PATH="$PATH:$HOME/.local/share/coursier/bin"
# <<< coursier install directory <<<

# flutter install directory
export PATH="$HOME/development/flutter/bin:$PATH"

# opam configuration
test -r $HOME/.opam/opam-init/init.sh && . $HOME/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

