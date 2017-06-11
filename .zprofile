echo "login to zsh"

export EDITOR=nvim
export VISUAL=nvim

export PATH="$HOME/bin:$PATH"
export PATH="$HOME/usr/bin:$PATH"
export PATH="$HOME/usr/local/bin:$PATH"

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
export XDG_CONFIG_HOME=$HOME/.local/share

export LESS='--RAW-CONTROL-CHARS'
export LESSOPEN='| /usr/local/bin/source-highlight-esc.sh %s'


if [ -d $HOME/.anyenv ] ; then
	export PATH="$HOME/.anyenv/bin:$PATH"
	eval "$(anyenv init - zsh)"
fi
if type pyenv > /dev/null ; then
    eval "$(pyenv virtualenv-init - zsh)"
fi

#powerline-daemon -q
#. ~/usr/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh

# dropbox
#dropbox.py status | ruby -e "if STDIN.gets.eql? %{Dropbox isn\'t running\!\n} then system('dropbox.py start') end"
