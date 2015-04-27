#!/bin/zsh

# Install a package and commit this to the repository in /etc.
# Parameters: the package to be installed.
function installpkg () {
    pushd /etc
    pacman --no-confirm -S $1
    if [[ $? == 0 ]]; then
        git add .
        git commit -am "[INSTALL] $1"
    fi
    popd
}

