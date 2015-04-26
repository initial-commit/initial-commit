# install git first in order to track (and thus, document) almost all changes we
# are doing to the system. The only "next big thing" would have been to remaster
# the ArchLinux .iso

set -e
set -x

echo "bootstrapping root"
pacman-db-upgrade
exit 0

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

