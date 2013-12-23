#!/bin/sh

# get submodule
git submodule init
git submodule update
git submodule foreach 'git checkout master'

# create symbolic link
ln -snf `pwd`/.tmux.d ~/.tmux.d
ln -snf `pwd`/.vim ~/.vim
ln -sf `pwd`/.gitconfig ~/.gitconfig
ln -sf `pwd`/.my.cnf ~/.my.cnf
ln -sf `pwd`/.smartcd_config ~/.smartcd_config
ln -sf `pwd`/.screenrc ~/.screenrc
ln -sf `pwd`/.vimrc ~/.vimrc
ln -sf `pwd`/.zshrc ~/.zshrc.pre-oh-my-zsh
ln -sf `pwd`/.tmux.conf ~/.tmux.conf
ln -sf `pwd`/.perltidyrc ~/.perltidyrc
