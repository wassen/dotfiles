test -r ~/.bashrc && . ~/.bashrc
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export PATH="$HOME/.cargo/bin:$PATH"

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[ -f /Users/kazuki_asayama/.config/.dart-cli-completion/bash-config.bash ] && . /Users/kazuki_asayama/.config/.dart-cli-completion/bash-config.bash || true
## [/Completion]

