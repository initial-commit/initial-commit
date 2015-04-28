# install git first in order to track (and thus, document) almost all changes we
# are doing to the system. The only "next big thing" would have been to remaster
# the ArchLinux .iso

# Install a package and commit this to the repository in /etc.
# Parameters: the package to be installed.
function installpkg () {
    pushd /etc
    pacman --noconfirm -S "$1"
    if [[ $? == 0 ]]; then
        git add .
        #TODO: check if anything is staged
        git commit -m "[INSTALL] $1"
        pushd /var/log
        git add .
        git commit -m "[INSTALL] $1"
        popd
        #TODO: write data to a syslog-ng file, which will be replayed back later
    fi
    popd
}

# Initialise a git repository in a given directory.
# Parameters: the directory where to init the repo.
function start_versioning () {
    pushd "$1" > /dev/null
    #TODO: special handling if there is already a repo
    git init
    git add .
    git commit -m "Initial commit"
    #TODO: write data to a syslog-ng file, which will be replayed back later
    popd > /dev/null
}


set -e
set -x

pacman-db-upgrade

pacman --noconfigm -S git
alias git=git --author "${BOXROOT_ROOT_NAME} <${BOXROOT_ROOT_EMAIL}>"

start_versioning /etc
start_versioning /var/log

installpkg zsh
installpkg rxvt-unicode

pushd /etc > /dev/null
chsh -s /bin/zsh
git add .
git commit -am "change default shell for root to zsh"
popd > /dev/null

find ! -name '.ssh' -exec rm -f {} +
unalias git
git config --global user.name "${BOXROOT_ROOT_NAME}"
git config --global user.email "${BOXROOT_ROOT_EMAIL}"
git init .
git remote add origin https://github.com/initial-commit/root.git
git fetch --all
git checkout -t origin/master
