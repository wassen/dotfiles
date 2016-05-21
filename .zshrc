#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# export WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"
autoload select-word-style
select-word-style bash

# Keybinding

## Del, Home and End
## [3~ = Ctrl+V -> Del
bindkey "[3~" delete-char
bindkey "[1~" beginning-of-line
bindkey "[4~" end-of-line

#bindkey "" backward-kill-word
#bindkey "" kill-word
# (delete-word)もあり)
# Shift + Tab 補完逆周り
bindkey "[Z" reverse-menu-complete

if [ -n "$SSH_CLIENT" ]; then ssh="from `echo $SSH_CLIENT|cut -f1 -d " "` "
fi

FG_GREEN="%{[38;5;037m%}"
FG_RED="%{[38;5;001m%}"
RESET_COLOR="%{[0m%}"

#if [ $(id -u) -eq 0 ];
#then
# PROMPT="${FG_RED}[%W %T %n@%m $ssh%~]${RESET_COLOR}
## "
#else
# PROMPT="${FG_GREEN}[%W %T %n@%m $ssh%~]${RESET_COLOR}
#$ "
#fi

case "${OSTYPE}" in
    linux*)
    alias ls='ls --color=auto'
    ;;
    darwin*)
    alias ls='ls -G'
    ;;
esac

function _killpid() {
	for arg in "$@"
	do
		cat /var/run/$arg.pid | xargs kill
	done
}

#alias
alias sudo='sudo '
alias l='ls'
alias ll='ls -l'
alias la='ls -a'
alias c='cd ..'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
#alias git='git '
alias commit='git commit -m'
#alias sctl='systemctl '
alias tunnel='ssh -f -N'
alias killpid='_killpid'
alias vim='vim -u $HOME/.vimrc'

#env設定
export EDITOR=vim
export PATH="$HOME/usr/bin:$PATH"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$HOME/usr/lib/pkgconfig"

if [ -d $HOME/.anyenv ] ; then
	export PATH="$HOME/.anyenv/bin:$PATH"
	eval "$(anyenv init -)"
fi
