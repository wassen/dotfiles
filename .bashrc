if [ -n "$SSH_CLIENT" ]; then ssh="from `echo $SSH_CLIENT|cut -f1 -d " "` "
fi

if [ $(id -u) -eq 0 ];
then
 PS1="\e[91m\e[40m\][\d \t \u@\h $ssh\W]\[\e[0m\]\n\\$ "
else
 PS1="\e[36m\e[40m\][\d \t \u@\h $ssh\W]\[\e[0m\]\n\\$ "
fi

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
		#kill `cat /var/run/$arg.pid`
	done
}

function _tunnel(){
	ssh -f -N $@
	#echo $!
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
alias git='git '
alias commit='commit -m'
#alias sctl='systemctl '
alias tunnel='_tunnel'
alias killpid='_killpid'

#PATH設定
export PATH="$HOME/usr/bin:$PATH"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$HOME/usr/lib/pkgconfig"

if [ -d $HOME/.anyenv ] ; then
	export PATH="$HOME/.anyenv/bin:$PATH"
	eval "$(anyenv init -)"
fi
