
backup_directory="$HOME/Documents/backups"

function push_wassen_note {
  set -ue

  # cd workspace/github.o-in.dwango.co.jp/wassen/note/

  # 自動Commitしたい
  # git remote に backupを作って
  # これ、loginのときのほうが良いか？
}

function brew_leaves {
  mkdir -p "$backup_directory"
  target="$backup_directory/brew_leaves"

  if [[ ! $(find $target -mmin -720) ]]; then
    echo "brew leaves..."
    brew leaves > $target
  fi
}

function brew_cask_list {
  mkdir -p "$backup_directory"
  target="$backup_directory/brew_casks"

  # （一日一回バックアップしたい）
  # 前回の更新から一日以内のファイルが無ければ
  # -mmin +720にして!を外すと、ファイルが無いときにすり抜けるので注意
  # -mtime -1にすると、どんどん後ろにズレていくので、12時間に変更した
  if [[ ! $(find $target -mmin -720) ]]; then
    echo "brew casks..."
    brew casks > $target
  fi
}

brew_leaves
brew_cask_list

echo "log out"
