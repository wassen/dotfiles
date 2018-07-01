#!/bin/sh
# 増えていくのアホらしいし、一括で全部できるスクリプトがほしい
dotfiles="
.vimrc
.bashrc
.bash_profile
.zshenv
.zpreztorc
.gitconfig
.gitignore_global
.gitconfig_user
.tmux.conf
"

for dotfile in $dotfiles; do
	ln -sf ~/dotfiles/$dotfile ~/$dotfile
done

rm -fr ~/.vim
ln -sf ~/dotfiles/.vim ~/.vim
rm -fr ~/.config
ln -sf ~/dotfiles/.config ~/.config
