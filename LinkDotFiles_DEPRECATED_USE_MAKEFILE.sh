#!/bin/sh
# 増えていくのアホらしいし、一括で全部できるスクリプトがほしい
dotfiles="
.vimrc
.bashrc
.bash_profile
.zshenv
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
# .config handling
if [ -L "$HOME/.config" ]; then
    rm "$HOME/.config"
    mkdir -p "$HOME/.config"
elif [ ! -d "$HOME/.config" ]; then
    mkdir -p "$HOME/.config"
fi

for config in "$HOME/dotfiles/.config/"*; do
    target="$HOME/.config/$(basename "$config")"
    ln -sf "$config" "$target"
done


# .vim, .vimrc
# vimってXDG未対応？

# .tmux.conf
# つかわん

# .gitconfig_user
# ない
