#!/usr/bin/env bash

cd "$(dirname "$0")"
for f in `ls -d \.* | grep -v git`
do
    ln -fs $PWD/$f ~
done

mkdir -p ~/.config
ln -fs $PWD/nvim ~/.config/nvim

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

echo Done

echo Next you need to do:
echo "1) To fix repeating keys problem on Mac OS execute: 'defaults write -g ApplePressAndHoldEnabled -bool false'"
echo "2) Download, install and set as default for iTerm2 following font: https://github.com/powerline/fonts/blob/master/Meslo%20Slashed/Meslo%20LG%20M%20Regular%20for%20Powerline.ttf"
