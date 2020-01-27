#!/bin/bash -ue



formulae=(
	exa
	direnv
	fzf
	ghq
	git
	vim
	zplug
)
brew install ${formulae[@]}
cask_formulae=(
	alfred
	clipy
	dropbox
	google-japanese-ime
	homebrew/cask-fonts/font-hack
	marshallofsound-google-play-music-player
	slack
	vivaldi
)

brew cask install ${cask_formulae[@]}


# optional
# Android Studio
# Amethyst
# Adobe XD
# cask install corretto ← これ11しかインストールできない
