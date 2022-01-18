#!/bin/bash -ue



formulae=(
	exa
	direnv
	fzf
	ghq
	git
	vim
	zplug
	zsh
)
brew install ${formulae[@]}
cask_formulae=(
	alfred
	clipy
	dropbox
	google-japanese-ime
	homebrew/cask-fonts/font-hack
	iterm2
	slack
	vivaldi
)

brew install --cask ${cask_formulae[@]}


# optional
# Android Studio
# Amethyst
# Adobe XD
# cask install corretto ← これ11しかインストールできない
