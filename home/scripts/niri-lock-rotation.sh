#!/bin/sh

state_directory="$HOME/.local/share/niri-auto-rotate"
lock_file="$state_directory/lock"

mkdir -p ~/.local/share/niri-auto-rotate

if [[ -f $lock_file ]]; then
  echo "Unlocking screen."
  rm $lock_file
else
  echo "Locking screen."
  touch $lock_file
fi

