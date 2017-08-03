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
# ひとつは**の中にわたし、その他を外に入れたい感じ
function wfind(){
	find . -name *$arg[0]*
}

function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

function peco-history-selection() {
    BUFFER=$(history -n 1 | tail -r  | awk '!a[$0]++' | peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

# キャン��ルした時cdしちゃう不具合
function peco-cd() {
		local selected_dir=`dirs | tr ' ' '\n' | peco --query "$LBUFFER"`
    if [ -n "$selected_dir" ]; then
      BUFFER="cd ${selected_dir}"
      zle accept-line
    fi
}
zle -N peco-cd
bindkey '^Bc' peco-cd

# find . -type f | grep .java | peco

# function project_commands() {
# 		local command=`cat ~/.local/share/coBalt | peco --query "$LBUFFER"`
#     BUFFER="${command}"
#     CURSOR=$#BUFFER
# }
# zle -N project_commands
# bindkey '^B' project_commands

# 拡張子指定と見つかったファイルディレクトリの表示、ハイライト
function _search() {
  find . -type f | grep -v .git | grep $1
}

function hist(){
  history 0 | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n10
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
alias gti='git'
alias gl='git log'
alias gs='git status'
#alias sctl='systemctl '
alias tunnel='ssh -f -N'
alias killpid='_killpid'
alias search='_search'
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

bindkey "^U" backward-kill-line
