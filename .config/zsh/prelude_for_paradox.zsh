#
# Functions in .zprezto/modules/editor/init.zsh
#

# Exposes information about the Zsh Line Editor via the $editor_info associative
# array.
function editor-info {
  # Clean up previous $editor_info.
  unset editor_info
  typeset -gA editor_info

  if [[ "$KEYMAP" == 'vicmd' ]]; then
    zstyle -s ':prezto:module:editor:info:keymap:alternate' format 'REPLY'
    editor_info[keymap]="$REPLY"
  else
    zstyle -s ':prezto:module:editor:info:keymap:primary' format 'REPLY'
    editor_info[keymap]="$REPLY"

    if [[ "$ZLE_STATE" == *overwrite* ]]; then
      zstyle -s ':prezto:module:editor:info:keymap:primary:overwrite' format 'REPLY'
      editor_info[overwrite]="$REPLY"
    else
      zstyle -s ':prezto:module:editor:info:keymap:primary:insert' format 'REPLY'
      editor_info[overwrite]="$REPLY"
    fi
  fi

  unset REPLY
  zle zle-reset-prompt
}
zle -N editor-info

# Reset the prompt based on the current context and
# the ps-context option.
function zle-reset-prompt {
  if zstyle -t ':prezto:module:editor' ps-context; then
    # If we aren't within one of the specified contexts, then we want to reset
    # the prompt with the appropriate editor_info[keymap] if there is one.
    if [[ $CONTEXT != (select|cont) ]]; then
      zle reset-prompt
      zle -R
    fi
  else
    zle reset-prompt
    zle -R
  fi
}
zle -N zle-reset-prompt

# Updates editor information when the keymap changes.
function zle-keymap-select {
  zle editor-info
}
zle -N zle-keymap-select

# Enables terminal application mode and updates editor information.
function zle-line-init {
  # The terminal must be in application mode when ZLE is active for $terminfo
  # values to be valid.
  if (( $+terminfo[smkx] )); then
    # Enable terminal application mode.
    echoti smkx
  fi

  # Update editor information.
  zle editor-info
}
zle -N zle-line-init
