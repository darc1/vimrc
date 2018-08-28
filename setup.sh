#!/bin/bash

#install for fzf, to find hidden files
sudo apt-get install -y silversearcher-ag

#install for YouCompleteMe
sudo apt-get install build-essential cmake -y
sudo apt-get install python-dev python3-dev

#backup current .vimrc
cp ~/.vimrc ~/.vimrc.old

#copy vimrc
cp .vimrc ~/.vimrc

