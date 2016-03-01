#myself
if [ -n "$SSH_CLIENT" ]; then ssh="from `echo $SSH_CLIENT|cut -f1 -d " "` "
fi

if [ $(id -u) -eq 0 ];
then
 PS1="\e[91m\e[40m\][\d \t \u@\h $ssh\W]\[\e[0m\]\n\\$ "
else
 PS1="\e[36m\e[40m\][\d \t \u@\h $ssh\W]\[\e[0m\]\n\\$ "
fi

alias sudo='sudo '
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

alias python='python3'
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
alias killpid='_killpid'

# added by Anaconda3 2.4.1 installer
export PATH="/home/is/kazuki-a/anaconda3/bin:$PATH"
