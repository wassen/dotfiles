.PHONY: _mac _brew _key_repeat hoge ho\ ge/ho\ ge

DOTFILE_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
export HOMEBREW_NO_AUTO_UPDATE := 1

ho\ ge/ho\ ge:
	echo '$(shell dirname "$@")'

default:
	:

_mac: _symlinks _key_repeat _brew .config/nvim/dein ${HOME}/.config ${XDG_DATA_HOME}/nvim/site/pack/packer/opt/packer.nvim
	:

${HOME}/.bashrc:
	ln -sf ${DOTFILE_DIR}/.bashrc ${HOME}/.bashrc
${HOME}/.bash_profile:
	ln -sf ${DOTFILE_DIR}/.bash_profile ${HOME}/.bash_profile
${HOME}/.zshenv:
	ln -sf ${DOTFILE_DIR}/.zshenv ${HOME}/.zshenv
${HOME}/.gitconfig:
	ln -sf ${DOTFILE_DIR}/.gitconfig ${HOME}/.gitconfig
${HOME}/.gitignore_global:
	ln -sf ${DOTFILE_DIR}/.gitignore_global ${HOME}/.gitignore_global
${HOME}/.config:
	ln -sf ${DOTFILE_DIR}/.config ${HOME}/.config

_symlinks:
	${MAKE} ${HOME}/.bashrc
	${MAKE} ${HOME}/.bash_profile
	${MAKE} ${HOME}/.zshenv
	${MAKE} ${HOME}/.gitconfig
	${MAKE} ${HOME}/.gitignore_global
	${MAKE} ${HOME}/.config


/opt/homebrew/bin/brew:
	hash brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	@test -x /opt/homebrew/bin/brew && eval $$(/opt/homebrew/bin/brew shellenv) || (echo 'where is homebrew?' 1>&2; exit 125)

_brew: /opt/homebrew/bin/brew
	:
	# cat ${DOTFILE_DIR}/backups/formulae.txt | xargs brew install --formulae --quiet
	# displaylinkが不要になったらこれも不要
	# brew tap homebrew/cask-drivers
	# quietがcasksだけ効いてないが
	# cat ${DOTFILE_DIR}/backups/casks.txt | xargs brew install --casks --quiet

${XDG_DATA_HOME}/nvim/site/pack/packer/opt/packer.nvim:
	git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/opt/packer.nvim

_key_repeat:
	defaults write -g KeyRepeat -int 2
