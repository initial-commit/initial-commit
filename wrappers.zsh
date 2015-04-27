#!/bin/zsh

# Install a package and commit this to the repository in /etc.
# Parameters: the package to be installed.
function installpkg () {
    pushd /etc
    pacman --no-confirm -S $1
    if [[ $? == 0 ]]; then
        git add .
        git commit -am "[INSTALL] $1"
        if [[ $? == 1 ]]; then
            pacman --no-confirm -R $1
        fi
    fi
    popd
}

# Initialise a git repository in a given directory.
# Parameters: the directory where to init the repo.
function start_versioning () {
    pushd $1
    git init
    git add .
    git commit -am "Initial commit"
    popd
}

