#!/usr/bin/env bash

cd "$(dirname "$0")"
for f in `ls -d \.* | grep -v git`
do
    ln -fs $PWD/$f ~
done

arch -x86_64 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
arch -x86_64 brew install wget
arch -x86_64 brew install cmake
arch -x86_64 brew install vim --with-override-system-vi
arch -x86_64 brew install tmux
arch -x86_64 brew install reattach-to-user-namespace
arch -x86_64 brew install ag
arch -x86_64 brew install ctags
arch -x86_64 brew install typespeed
arch -x86_64 brew install git
arch -x86_64 brew install node
arch -x86_64 brew install zsh
arch -x86_64 brew install antigen

npm install -g typescript

echo Please input git user name
read name
echo Please input git user email
read email
cp .gitconfig ~/.gitconfig
git config --global user.name "$name"
git config --global user.email "$email"

cp git-completion.bash ~/git-completion.bash
cp git-prompt.sh ~/git-prompt.sh
cp gruvbox_256palette.sh ~/gruvbox_256palette.sh

touch ~/.local.vimrc
touch ~/.typespeed/score

source ~/.profile

echo Fetch/update neobundle.vim
rm -rf ~/.vim/bundle/neobundle.vim
wget -q https://codeload.github.com/Shougo/neobundle.vim/tar.gz/master
mkdir -p .vim/bundle/
tar xf master
mv neobundle.vim-master .vim/bundle/neobundle.vim
rm -rf master
git clone https://github.com/myshov/xkbswitch-macosx                                                                                                                                                                                                                                                                                        ✔  12:18:33
cp xkbswitch-macosx/bin/xkbswitch /usr/local/bin
rm -rf xkbswitch-macosx
git clone https://github.com/myshov/libxkbswitch-macosx                                                                                                                                                                                                                                                                                        ✔  12:18:33
cp libxkbswitch-macosx/bin/libxkbswitch.dylib /usr/local/lib
rm -rf libxkbswitch-macosx
echo Done

echo Next you need to do:
echo "1) Set iTerm2 settings: Keys -> Remap Modifier Keys -> Right command to Control"
echo "2) Set Mac OS settings: System Preferences -> Keyboard -> Modifier Keys -> Caps Lock to Control"
echo "3) Download and install gruvbox theme for iterm2: https://github.com/morhetz/gruvbox-contrib/blob/master/iterm2/gruvbox-dark.itermcolors"
echo "4) Set default colour scheme for iTerm2: Profiles -> Colors -> Color Presets to gruvbox"
echo "5) Download, install and set as default for iTerm2 following font: https://github.com/powerline/fonts/blob/master/Meslo%20Slashed/Meslo%20LG%20M%20Regular%20for%20Powerline.ttf"
echo "6) Execute sudo vim /etc/shells and add line /usr/local/bin/zsh"
echo "7) Execute chsh -s /usr/local/bin/zsh to set zsh default shell"
echo "8) Restart iTerm 2 and run vim"
