echo "Run-Control zsh"

# Zplug settings
if [ -d /usr/local/opt/zplug ]; then
	export ZPLUG_HOME=/usr/local/opt/zplug
elif [ -d /opt/homebrew/opt/zplug ]; then
	export ZPLUG_HOME=/opt/homebrew/opt/zplug
else
	export ZPLUG_HOME=$XDG_DATA_HOME/opt/zplug
fi


if [ -f $ZPLUG_HOME/init.zsh ] ; then
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

	if ! zplug check ; then
		zplug install
	fi
fi

# options
export HISTFILE=$XDG_DATA_HOME/zsh/history
mkdir -p  $XDG_DATA_HOME/zsh/
touch $HISTFILE
export HISTSIZE=100000
export SAVEHIST=100000

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
    # TODO: tac or tail -r
    # awk '!seen[$0]++' はsortなしのuniq
	buffer=$(history -n 1 | tail -r | awk '!seen[$0]++' | fzf --no-sort --prompt "bck-i-search> " --query "$BUFFER")

	# buffer=$(history -n 1 | tail -r  | awk '!a[$0]++' | fzf --no-sort --prompt "bck-i-search> " --query "$BUFFER")
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
      # TODO: tac or tail -r
	  BUFFER=$(history -n 1 | tail -r | peco --query "$LBUFFER")
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
## better something
if hash exa; then
	alias ls='exa'
fi
# if hash nvim; then
# 	alias vim='nvim'
# fi

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
alias g='git'
alias gti='git'
alias gl='git log'
alias gs='git status'
alias gitcd='cd $(git rev-parse --show-toplevel)'
alias grep='grep --color=auto'
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
alias latexmake='latexmk -pdfdvi -pvc'

## global alias
### git branches
alias -g  B='$(git branch -a | fzf --multi --preview "git show {1}" --prompt "All Branches> "    | sed -e "s/^[\*\+]\s*//g")'
alias -g RB='$(git branch -r | fzf --multi --prompt "Remote Branches> " | sed -e "s/^\*\s*//g")'
alias -g LB='$(git branch    | fzf --multi --prompt "Local Branches> "  | sed -e "s/^\*\s*//g")'
### Directories
alias -g  D='$(ls -d */               | fzf --multi --prompt "Directories> "   )'
alias -g  F='$(ls -F   | grep -v "/$" | fzf --multi --prompt "Files> " | sed -e "s/*//" )'
## 事前にcutしておかない場合、previewがめんどくさい・・・関数にできない？
## Git管理下にないファイルの場合、変更点じゃなくてファイルそのものを表示したい。
## xargs git diff じゃなくて git diff $() にしたかったけどうまくいかない
# double quoteの扱いが面倒 alias -g  S='"$(git status --short | fzf --multi --preview "sh -c \"echo {} | awk '\''{print \\\$2}'\'' | xargs git diff\"" --prompt "Git Files> " | cut -c 4-)"'
# alias -g  S='"$(git status --short | fzf --multi --preview "sh -c \"echo {} | awk '\''{print \\\$2}'\'' | xargs git diff\"" --prompt "Git Files> " | cut -c 4- | sed \"s/^\\"//;s/\\"$//\")"'
# name statusとやらもあるが挙動は違いそう untrackedが入らないから駄目です
# alias -g  S='"$(git diff --name-only --relative | fzf --multi --preview "git diff {}" --prompt "Git Files> ")"'
# --porcelain は色がなく相対パスなので駄目です

function get_substring_from_third_char() {
    while IFS= read -r line; do
        echo "${line:3}"
    done
}

function hoge() {
    # git status -z に status.relativePaths=trueが効かない。相対パスがうまくいかない
    # ファイル名の末尾が空白の場合はうまくいかない
    # pythonのshlexとか使うか
    # プレビューが表示されていない
    git -c color.ui=always status --no-branch --short --no-renames -z | tr '\0' '\n' | fzf --ansi --multi --prompt "$(git rev-parse --abbrev-ref HEAD) Status >" --preview "echo {} | awk '{\$1=\"\"; print \$0}'" | get_substring_from_third_char
}
# alias -g  S='"$(hoge)"'

function fuga() {
    # 今度は複数選択が上手くいかない。キレそう
    # # "$(fuga)" にしてたからだったわ
    git -c color.ui=always status --no-branch --short --no-renames | fzf --ansi --multi --prompt "$(git rev-parse --abbrev-ref HEAD) Status >" --preview "git diff \"\$(echo {} | $ZDOTDIR/python/parse_git_status.py)\"" | $ZDOTDIR/python/parse_git_status.py
}
alias -g  S='$(fuga)'
# ダブルクオートがない版 空白文字が駄目
alias -g  U='$(git -c color.ui=always status --no-branch --short --no-renames -z | tr '\''\0'\'' '\''\n'\'' | fzf --ansi --multi --prompt "$(git rev-parse --abbrev-ref HEAD) Status >" --preview "echo {} | awk '\''{\$1=\"\"; print \$0}'\''" | awk '\''{print $2}'\'')'
# ダブルクオートがある版 /がパス区切りとされていなさそうでファイルが開けない
alias -g  K='"$(git -c color.ui=always status --no-branch --short --no-renames -z | tr '\''\0'\'' '\''\n'\'' | fzf --ansi --multi --prompt "$(git rev-parse --abbrev-ref HEAD) Status >" --preview "echo {} | awk '\''{\$1=\"\"; print \$0}'\''" | awk '\''{print $2}'\'') "'

# splitoonの出番か
# alias -g  R='$(git log --oneline | fzf --no-sort --preview "sh -c \"git --no-pager show $(echo {} | cut -b 1)\"" --prompt "Git Revisions> " | cut -f 1 -d " ") '
alias -g  R='$(git log --oneline | fzf --multi --no-sort --preview "sh -c \"git --no-pager show \\\$(echo {} | awk '\''{print \\\$1}'\'')\"" --prompt "Git Revisions> " | awk '\''{print $1}'\'')'
# この手のやつに空白区切り、複数選択とかでうまくいくかテストを書きたい。
# "" をつけると複数選択が対処できず""をつけないと空白区切りが上手くいかない。fzfの出力はどうなってるんだこれ
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

function copy_commit_hash() {
	echo R | pbcopy
}

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

function lost-found() {
	for blob in $(git fsck --lost-found | grep blob | cut -d ' ' -f 3 ); do
		if git --no-pager show $blob | grep --quiet $1 ; then
			echo $blob
		fi
	done
}

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

mkdir -p $HOME/workspace/tmp
function deleteTmpOneMonth() {
	find $HOME/workspace/tmp -mindepth 1 -maxdepth 1 -mtime +30 -exec rm -fr {} +
	# exa --all $HOME/workspace/tmp | xargs -I{} find $HOME/workspace/tmp/{} -mtime +30 -depth 0 | xargs rm -fr
}
deleteTmpOneMonth

rm -fr $HOME/.aws

# alias -s 'tar.gz'='tar fx'
# unar

# Auto Update Brew
if ! ps x | grep -v "grep brew" | grep brew > /dev/null; then
	# (type brew > /dev/null && brew update > /dev/null &)
	# エラー出力はほしいが、tapの更新がエラー出力に出てきて煩わしいので一旦捨てる
	(brew update 2> /dev/null 1> /dev/null &)
fi

# export PATH="$HOME/workspace/github.com/fwcd/KotlinLanguageServer/server/build/install/server/bin:$PATH"
# export JAVA_HOME="/Library/Java/JavaVirtualMachines/amazon-corretto-8.jdk/Contents/Home"

