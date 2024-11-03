echo "login to zsh"

# Check declaration of variable
# set -u

export EDITOR=nvim
export VISUAL=nvim

if [ -e /opt/homebrew/bin/brew ];
then
	eval $(/opt/homebrew/bin/brew shellenv)
fi

export PATH="$HOME/bin:$PATH"
export PATH="$HOME/usr/bin:$PATH"
export PATH="$HOME/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.opt/flutter/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/Library/Android/sdk/platform-tools/:$PATH"
export PATH="$HOME/Library/Android/sdk/tools/bin/:$PATH"
export PATH="${PATH}:${HOME}/.local/opt/flutter/bin"

# rubyenv が死ぬ
# export PATH="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp:$PATH"

export PATH="/usr/local/opt/ruby/bin:$PATH"

HOME_OPT=$HOME/opt
if [ -d $HOME_OPT ]
then
	bin_dirs=`find $HOME_OPT -name bin`
	for bin_dir in $bin_dirs
	do
		export PATH="$bin_dir":$PATH
	done
fi

#HOME_OPT=$HOME/opt
#if [ -d $HOME_OPT ]
#then
#	for in_opt in `/bin/ls $HOME_OPT`
#	do
#		export PATH="$HOME_OPT/$in_opt/bin:$PATH"
#	done
#fi


export PKG_CONFIG_PATH="$HOME/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH"
export LD_LIBRARY_PATH="$HOME/usr/local/lib:$HOME/usr/local/lib64":$LD_LIBRARY_PATH
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

export AWS_SHARED_CREDENTIALS_FILE=$XDG_CONFIG_HOME/aws/credentials
export AWS_CONFIG_FILE=$XDG_CONFIG_HOME/aws/config

export LESS='--RAW-CONTROL-CHARS'
export LESSOPEN='| /usr/local/bin/source-highlight-esc.sh %s'

# WSLでTrue Color
export COLORTERM=truecolor

# Options
export GREP_COLOR='1;32'
export FZF_DEFAULT_OPTS='
	--height 85% --reverse --border
	--color fg:252,bg:233,hl:67,fg+:252,bg+:235,hl+:81
	--color info:144,prompt:161,spinner:135,pointer:135,marker:118
'


if [ -d $HOME/.anyenv ] ; then
	export PATH="$HOME/.anyenv/bin:$PATH"
	eval "$(anyenv init - --no-rehash zsh)"
fi
if type pyenv > /dev/null ; then
    eval "$(pyenv virtualenv-init - --no-rehash zsh)"
fi

if hash direnv 2>/dev/null ; then
	eval "$(direnv hook zsh)"
fi

#powerline-daemon -q
#. ~/usr/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh

# dropbox
#dropbox.py status | ruby -e "if STDIN.gets.eql? %{Dropbox isn\'t running\!\n} then system('dropbox.py start') end"

function chpwd() {
	if [ ! -e ".git" ]; then
		return
	fi
	if git stash show 1> /dev/null 2> /dev/null; then
		echo -e "\e[38;5;161mStashが残ってるぞ\e[m"
	fi
}
