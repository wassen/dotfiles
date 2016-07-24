SHELL=$(which zsh) 

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

unsetopt cdable_vars

# export WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"
autoload select-word-style
select-word-style bash

# Keybinding
bindkey -e
## Del, Home and End
## [3~ = Ctrl+V -> Del
#bindkey "[3~" delete-char
#bindkey "[1~" beginning-of-line
#bindkey "[4~" end-of-line

#bindkey "" backward-kill-word
#bindkey "" kill-word
# (delete-word)もあり)
# Shift + Tab 補完逆周り
bindkey "[Z" reverse-menu-complete

#if [ -n "$SSH_CLIENT" ]; then ssh="from `echo $SSH_CLIENT|cut -f1 -d " "` "
#fi

#FG_GREEN="%{[38;5;037m%}"
#FG_RED="%{[38;5;001m%}"
#RESET_COLOR="%{[0m%}"

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
	alias open='xdg-open'
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
alias sudo='nocorrect sudo'
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
#xclipとの違い
alias cboard='xsel --clipboard --input'
alias hconf='./configure --prefix=$HOME/usr'
VIM_VERSION=`vim --version | head -1 | perl -ne '$_=($_=~/(\b\d+\.\d+\b)/)[0];s/\.//;print$_'`
alias vless='/usr/share/vim/vim${VIM_VERSION}/macros/less.sh'
alias tmux="TERM=xterm-256color tmux"
# du files(many file -> ff)
alias duff="du -hs *"
alias tree='tree --charset=C -NC'

#env設定

export EDITOR=vim
export VISUAL=vim
export PATH="$HOME/bin:$HOME/usr/bin:$PATH"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$HOME/usr/lib/pkgconfig"
#export LD_LIBRARY_PATH=""
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/usr/lib:$HOME/usr/lib64"
export XDG_CONFIG_HOME=$HOME/.local/share

#brew
export PATH="$HOME/.linuxbrew/sbin:$PATH"
export PATH="$HOME/.linuxbrew/bin:$PATH"
export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
#export LD_LIBRARY_PATH="$HOME/.linuxbrew/lib:$LD_LIBRARY_PATH"

export LESS='--RAW-CONTROL-CHARS'
export LESSOPEN='| /usr/local/bin/source-highlight-esc.sh %s'

if [ -d $HOME/.anyenv ] ; then
	export PATH="$HOME/.anyenv/bin:$PATH"
	eval "$(anyenv init -)"
fi

#export PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init -)"
