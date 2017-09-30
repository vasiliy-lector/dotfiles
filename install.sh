#!/usr/bin/env bash

cd "$(dirname "$0")"
for f in `find . -name '\.*' -exec basename {} \; | grep -v 'git\|\.$'`
do
    ln -fs $PWD/$f ~
done

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install wget
brew install cmake
brew install vim --with-override-system-vi
brew install tmux
brew install ag
brew install ctags

echo Please input git user name
read name
echo Please input git user email
read email
cp .gitconfig ~/.gitconfig
git config --global user.name "$name"
git config --global user.email "$email"

cp git-completion.bash ~/git-completion.bash
cp git-prompt.sh ~/git-prompt.sh

source ~/.profile

echo Fetch/update neobundle.vim
rm -rf ~/.vim/bundle/neobundle.vim
wget -q https://codeload.github.com/Shougo/neobundle.vim/tar.gz/master
mkdir -p .vim/bundle/
tar xf master
mv neobundle.vim-master .vim/bundle/neobundle.vim
rm master
echo Done

echo Next you need to do:
echo "1) Set iTerm2 settings: Keys -> Remap Modifier Keys -> Right command to Control"
echo "2) Set Mac OS settings: System Preferences -> Keyboard -> Modifier Keys -> Caps Lock to Escape"
echo "3) Set default colour scheme for iTerm2: Profiles -> Colors -> Color Presets to Solarized Dark"
echo "4) Download, install and set as default for iTerm2 following font: https://github.com/powerline/fonts/blob/master/Meslo%20Slashed/Meslo%20LG%20M%20Regular%20for%20Powerline.ttf"
echo "5) Restart iTerm 2 and run vim"
