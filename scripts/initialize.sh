#!/bin/sh

# get submodule
git submodule init
git submodule update
git submodule foreach 'git checkout master'

# create symbolic link
ln -snf `pwd`/.vim ~/.vim
ln -sf `pwd`/.gitconfig ~/.gitconfig
ln -sf `pwd`/.my.cnf ~/.my.cnf
ln -sf `pwd`/.screenrc ~/.screenrc
ln -sf `pwd`/.vimrc ~/.vimrc
ln -sf `pwd`/.zshrc ~/.zshrc
