#!/bin/sh
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
#sh ./installer.sh ~/.vim/dein
sh ./installer.sh ~/.local/share/nvim/dein
rm installer.sh