# install git first in order to track (and thus, document) almost all changes we
# are doing to the system. The only "next big thing" would have been to remaster
# the ArchLinux .iso

# Commit all changes in the current directory.
# If there is no git repository initialised at destination or there is nothing
# unstaged, exit silently.
# Parameters: - the directory where to make the commit
#             - the commit message
function commit_all () {
    pushd "$1" > /dev/null
    if [[ -d './.git' && ! -z $(git status --porcelain) ]]; then
        git add -A . > /dev/null
        echo "commit in '$1': '$2'"
        git commit -m "$2" > /dev/null
    fi
    popd > /dev/null
}

# Install a package and commit this to the repository in /etc.
# Parameters: the package to be installed.
function installpkg () {
    if ! (pacman -Q "$1" &>/dev/null); then
        echo "INSTALL: '$1'"
        pacman --noconfirm -S "$1" > /dev/null
    fi
    #TODO: we don't need .pacsave, .OLD, & co, git records it all
    commit_all "/etc" "[INSTALL] $1"
    commit_all "/var/log" "[INSTALL] $1"
    #TODO: write data to a syslog-ng file, which will be replayed back later
}

# Initialise a git repository in a given directory.
# Parameters: the directory where to init the repo.
function start_versioning () {
    pushd "$1" > /dev/null
    if [[ !( -d './.git') ]]; then
        git init
        git add . > /dev/null
        git commit -m "Initial commit" > /dev/null
    fi
    #TODO: write data to a syslog-ng file, which will be replayed back later
    popd > /dev/null
}

set -e
set -x

pacman-db-upgrade

find ! -path './.ssh*' ! -path . -exec rm -f {} \;

pacman --noconfirm -S git
git config --global user.name "${BOXROOT_ROOT_NAME}"
git config --global user.email "${BOXROOT_ROOT_EMAIL}"
start_versioning /etc
start_versioning /var/log
installpkg git

installpkg zsh

pushd /etc > /dev/null
chsh -s /bin/zsh
git add .
git commit -am "change default shell for root to zsh"
popd > /dev/null

git init .
git remote add origin https://github.com/initial-commit/root.git
git fetch --all
git checkout -t origin/master
