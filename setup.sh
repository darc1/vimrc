#!/bin/bash

#install for fzf, to find hidden files
sudo apt-get install silversearcher-ag -y

#install for YouCompleteMe
sudo apt-get install build-essential cmake -y
sudo apt-get install python-dev python3-dev -y

#install starscope
sudo apt-get install ruby ruby-dev -y
sudo gem install -V starscope

#backup current .vimrc
cp ~/.vimrc ~/.vimrc.old

#copy vimrc
cp .vimrc ~/.vimrc

mkdir -p ~/.vim/plugin/
cp ./cscope/cscope_maps.vim ~/.vim/plugin
