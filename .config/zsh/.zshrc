echo "Run-Control zsh"

# Zplug settings
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# zplug "sorin-ionescu/prezto"
# zplug 'modules/environment', from:prezto
# zplug 'modules/terminal', from:prezto
# zplug 'modules/editor', from:prezto
# source $ZDOTDIR/prelude_for_paradox.zsh
# zplug 'modules/history', from:prezto
# zplug 'modules/directory', from:prezto
# zplug 'modules/spectrum', from:prezto
# zplug 'modules/utility', from:prezto
# zplug 'modules/completion', from:prezto
# zplug "modules/prompt", from:prezto
# zstyle ':prezto:module:prompt' theme 'pure'
zplug mafredri/zsh-async, from:github
zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme
zplug zsh-users/zsh-completions

zplug load

# # Source Prezto.
# if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
#   source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
# fi

# Settings
setopt auto_pushd

# Completion
autoload -U compinit
compinit -u
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'

unsetopt cdable_vars

export WORDCHARS="*?_.[]~=&;!#$%^(){}<>"
# autoload select-word-style
# select-word-style bash

# Keybinding
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode
bindkey -M vicmd 'H' vi-first-non-blank
bindkey -M vicmd 'L' vi-end-of-line
bindkey -M viins "^?" backward-delete-char
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd 'V' edit-command-line
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

function 256(){
	for c in {000..255}; do echo -n "\e[38;5;${c}m $c" ; [ $(($c%16)) -eq 15 ] && echo;done;echo
}

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

function fzf-src() {
	local dir=$(ghq list > /dev/null | fzf +m --prompt "Repositories> " --preview "ls $(ghq root)/{}" --query "$LBUFFER")
	# paradoxのプロンプトを復活させる
	zle reset-prompt
	if [ -n "$dir" ]; then
		cd $(ghq root)/$dir
		BUFFER=""
		zle accept-line
	fi
}
zle -N fzf-src

function peco-src () {
	local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
	if [ -n "$selected_dir" ]; then
	  BUFFER="cd ${selected_dir}"
	  zle accept-line
	fi
	zle clear-screen
}
zle -N peco-src
bindkey '^]' fzf-src

function fzf-history-selection() {
	buffer=$(history -n 1 | tail -r  | awk '!a[$0]++' | fzf --prompt "bck-i-search> " --query "$BUFFER")
	if [ -n "$buffer" ]; then
		BUFFER=$buffer
		CURSOR=$#BUFFER
	fi
	# ESCしたらCURSORが消えるのが気に食わない
	# fzfの結果をちゃんとエラーかどうか判別したい
	zle reset-prompt
}
zle -N fzf-history-selection

function peco-history-selection() {
	  BUFFER=$(history -n 1 | tail -r  | awk '!a[$0]++' | peco --query "$LBUFFER")
	  CURSOR=$#BUFFER
}

zle -N peco-history-selection
bindkey '^R' fzf-history-selection

function fzf-cd() {
	local selected_dir=`dirs | tr ' ' '\n' | sort | uniq | fzf --query "$BUFFER"`
	zle reset-prompt
	if [ -n "$selected_dir" ]; then
		BUFFER="cd ${selected_dir}"
		zle accept-line
	fi
}

# キャン��ルした時cdしちゃう不具合
function peco-cd() {
		local selected_dir=`dirs | tr ' ' '\n' | peco --query "$LBUFFER"`
	  if [ -n "$selected_dir" ]; then
	    BUFFER="cd ${selected_dir}"
	    zle accept-line
	  fi
}
zle -N fzf-cd
bindkey '^Bc' fzf-cd

# find . -type f | grep .java | peco

function project_commands() {
	local command=$(cat ~/.config/commands | fzf --query "$BUFFER")
	BUFFER=$command
	CURSOR=$#BUFFER
	zle reset-prompt
}
zle -N project_commands
bindkey '^Bb' project_commands

# 拡張子指定と見つかったファイルディレクトリの表示、ハイライト
function _search() {
	find . -type f | grep -v .git | grep $1
}

function hist() {
	history 0 | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n10
}

function meshi() {
	python -c "import random;m=['鳥藤', 'カレー', 'コンビニ'];print(random.choice(m))"
}

function google() {
	googler $* --json --count 20 | jq -r '.[] | "\(.title)\t\(.url)"' | fzf --delimiter="\t" --with-nth=1 | awk -F "\t" '{print$2}' | xargs open
}

function mas-install() {
	mas search $1 | fzf | awk '{ print $1 }' | xargs mas install
}

# alias
alias sudo='nocorrect sudo'
alias ls='exa'
alias l='ls'
alias ll='ls -l'
alias la='ls -a'
alias c='cd ..'
alias cl='cd ..;ls'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
#alias git='git '
alias g='git'
alias gti='git'
alias gl='git log'
alias gs='git status'
alias gitcd='cd $(git rev-parse --show-toplevel)'
#alias sctl='systemctl '
alias tunnel='ssh -f -N'
alias killpid='_killpid'
alias search='_search'
#xclipとの違い
alias cboard='xsel --clipboard --input'
alias hconf='./configure --prefix=$HOME/usr/local'
VIM_VERSION=`vim --version | head -1 | perl -ne '$_=($_=~/(\b\d+\.\d+\b)/)[0];s/\.//;print$_'`
alias vless='/usr/local/share/vim/vim${VIM_VERSION}/macros/less.sh'
alias less='vim - -R'
alias tmux="TERM=xterm-256color tmux"
# du files(many file -> ff)
alias duff="du -hs *"
alias tree='tree --charset=C -NC'
alias latexmake='latexmk -pdfdvi -pvc'

## global alias
### git branches
alias -g  B='$(git branch -a | fzf --multi --preview "git show {1}" --prompt "All Branches> "    | sed -e "s/^\*\s*//g")'
alias -g RB='$(git branch -r | fzf --multi --prompt "Remote Branches> " | sed -e "s/^\*\s*//g")'
alias -g LB='$(git branch    | fzf --multi --prompt "Local Branches> "  | sed -e "s/^\*\s*//g")'
### Directories
alias -g  D='$(ls -d */               | fzf --multi --prompt "Directories> "   )'
alias -g  F='$(ls -F   | grep -v "/$" | fzf --multi --prompt "Files> " | sed -e "s/*//" )'
## 事前にcutしておかない場合、previewがめんどくさい・・・関数にできない？
alias -g  S='$(git status --short | fzf --multi --preview "cat {}" --prompt "Git Files> " | cut -c 4-)'
# splitoonの出番か
# alias -g  R='$(git log --oneline | fzf --no-sort --preview "sh -c \"git --no-pager show $(echo {} | cut -b 1)\"" --prompt "Git Revisions> " | cut -f 1 -d " ") '
alias -g  R='$(git log --oneline | fzf --multi --no-sort --preview "sh -c \"git --no-pager show \\\$(echo {} | awk '\''{print \\\$1}'\'')\"" --prompt "Git Revisions> " | awk '\''{print $1}'\'')'
alias -g  G='$(git ls-files | fzf --multi --preview "cat {}" --prompt "Git Files> " )'
### Processes
alias -g  P='$(ps x -o pid,command | fzf --multi --prompt "Processes> " | awk "{print \$1}")'
### Docker
alias -g DI='$(docker images | fzf --multi --prompt "Docker images> " | awk "{print \$3}")'
alias -g DC='$(docker ps -a | fzf --multi --prompt "Docker containers> " | awk "{print \$1}")'

if hash porg 2> /dev/null
then
	alias porg_install='porg -lD "make install"'
fi

#env設定
# zprofileに移行


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

bindkey "^U" backward-kill-line

# Pure theme
NORMAL_ERROR_COLOR=220
INSERT_ERROR_COLOR=200
NORMAL_COLOR=220
NORMAL_PROMPT="%(?.%F{$NORMAL_COLOR}.%F{$NORMAL_ERROR_COLOR})❮%f"
INSERT_COLOR=038
INSERT_PROMPT="%(?.%F{$INSERT_COLOR}.%F{$INSERT_ERROR_COLOR})❯%f"
PROMPT='%(?.%F{$PROMPT_COLOR}.%F{$ERROR_COLOR})${VIM_PROMPT}%f '

prompt_pure_update_vim_prompt() {
	  zle || {
	      print "error: pure_update_vim_prompt must be called when zle is active"
	      return 1
	  }
	  VIM_PROMPT="${${KEYMAP/vicmd/$NORMAL_PROMPT}/(main|viins)/$INSERT_PROMPT}"
	  zle .reset-prompt
}
# ${${KEYMAP/vicmd/❮}/(main|viins)/❯}
function zle-line-init zle-keymap-select {
	  prompt_pure_update_vim_prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# function fcd() {
# 	cd $*
# }
# 
# function _cd() {
# 	# fzfを全画面にしないとレイアウトが壊れる
# 	# 2つめの良いとり方ないのか
# 	arg=$(echo $BUFFER | cut -f 2 -d " ")
# 	# fzfの結果、値が空なら終了するとかにすれば行けそう
# 	_values 'cd' $(ls -d */ | fzf --height=0 --query=$arg)
# }
# 
# compdef _cd fcd

function ec() {
	echo $*
}

function _ec() {
	# fzfを全画面にしないとレイアウトが壊れる
	_values 'fzf' $(echo "a\nb" | fzf --height=0)
}

compdef _ec ec

ls --all $HOME/workspace/tmp | xargs -I{} find $HOME/workspace/tmp/{} -mtime +30 -depth 0 | xargs rm -fr
rm -fr $HOME/.aws
