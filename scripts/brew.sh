#!/bin/bash -ue

formulae=(
	exa
	vim
)
brew install ${formulae[@]}
cask_formulae=(
	vivaldi
	marshallofsound-google-play-music-player
	clipy
	dropbox
)

brew cask install ${cask_formulae[@]}

