#!/usr/bin/env zsh

ANY_ENV_PATH=$HOME/.anyenv
git clone https://github.com/riywo/anyenv $ANY_ENV_PATH
source $HOME/.zshrc
$ANY_ENV_PATH/bin/anyenv install pyenv
source $HOME/.zshrc
# 絶対参照にした方がいいか？
pyenv install 3.5.1
