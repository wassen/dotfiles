echo "Run-Control zsh"

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
alias cl='cd ..;ls'
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
alias hconf='./configure --prefix=$HOME/usr/local'
VIM_VERSION=`vim --version | head -1 | perl -ne '$_=($_=~/(\b\d+\.\d+\b)/)[0];s/\.//;print$_'`
alias vless='/usr/local/share/vim/vim${VIM_VERSION}/macros/less.sh'
alias tmux="TERM=xterm-256color tmux"
# du files(many file -> ff)
alias duff="du -hs *"
alias tree='tree --charset=C -NC'
alias grep='grep --color=auto'
alias latexmake='latexmk -pdfdvi -pvc'

if hash porg 2> /dev/null
then
	alias porg_install='porg -lD "make install"'
fi

#env設定
# zprofileに移行


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
