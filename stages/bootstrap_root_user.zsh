# install git first in order to track (and thus, document) almost all changes we
# are doing to the system. The only "next big thing" would have been to remaster
# the ArchLinux .iso

set -e
set -x

echo "bootstrapping root"
pacman-db-upgrade
exit 0

#TODO: basically the following, but nicer and version pacman.log too (and
#anything which may seem important) as early in the process as possible.
#nicer also means: use variables.sh
#
#the user root's environment is considered bootstrapped when its default shell
#is zsh, and it has a clean directory cloned from initial-commit/root.git
#
#that repository will contain wrapper zsh functions for all common commands:
#git commit every small change to /etc/, /root/, and so on.
#
#once this is done, it's time for ./install to be executed (which will use
#those shell functions)

pacman --no-configm -S git
alias git=git --author "${USER_NAME} <${USER_EMAIL}>"

pushd /etc
git init
git add .
git commit -am "Initial commit"

pacman --no-confirm -S zsh
git add .
git commit -am "[INSTALL] zsh"

pacman --no-confirm -S rxvt-unicode
git add .
git commit -am "[INSTALL] rxvt-unicode"

chsh -s /bin/zsh
git add .
git commit -am "change default shell for root to zsh"

popd
find ! -name '.ssh' -exec rm -f {} +
unalias git
git config --global user.name root
git config --global user.email root+root@initial-commit.org
echo 'for file in $HOME/.zsh/*.zsh; do source "${file}"; done' > .zshrc
mkdir .zsh/
echo 'PATH=$HOME/bin:$PATH' > .zsh/10_path.zsh
mkdir bin/
git add -A .
git commit -m "Initial commit"
popd

