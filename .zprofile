echo "login to zsh"

export EDITOR=vim
export VISUAL=vim

export PATH="$HOME/bin:$PATH"
export PATH="$HOME/usr/bin:$PATH"
export PATH="$HOME/local/bin:$PATH"

export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$HOME/usr/lib/pkgconfig"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/usr/lib:$HOME/usr/lib64"
export XDG_CONFIG_HOME=$HOME/.local/share

export LESS='--RAW-CONTROL-CHARS'
export LESSOPEN='| /usr/local/bin/source-highlight-esc.sh %s'

if [ -d $HOME/.anyenv ] ; then
	export PATH="$HOME/.anyenv/bin:$PATH"
	eval "$(anyenv init -)"
fi

#powerline-daemon -q
#. ~/usr/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
