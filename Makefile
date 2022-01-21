.PHONY: _mac _brew _key_repeat hoge

DOTFILE_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

default:
	:

_mac: _symlinks _key_repeat _brew .config/nvim/dein ${HOME}/.config
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

_symlinks: ${HOME}/.bashrc ${HOME}/.bash_profile ${HOME}/.zshenv ${HOME}/.gitconfig ${HOME}/.gitignore_global ${HOME}/.config
	:

/opt/homebrew/bin/brew:
	hash brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	@test -x /opt/homebrew/bin/brew && eval $$(/opt/homebrew/bin/brew shellenv) || (echo 'where is homebrew?' 1>&2; exit 125)

_brew: /opt/homebrew/bin/brew
	cat ${DOTFILE_DIR}/backups/formulae.txt | xargs brew install --formulae --quiet
	# quietがcasksだけ効いてないが
	cat ${DOTFILE_DIR}/backups/casks.txt | xargs brew install --casks --quiet

.config/nvim/dein:
	curl 'https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh' | bash -s '.config/nvim/dein'

_key_repeat:
	defaults write -g KeyRepeat -int 2
