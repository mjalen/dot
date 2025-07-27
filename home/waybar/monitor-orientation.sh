#! /bin/sh

state_directory="$HOME/.local/share/niri-auto-rotate"
lock_file="$state_directory/lock"

format_output() {
    text=$1
    alt=$2
    echo "{ \"text\": \"${text}\", \"alt\": \"${alt}\", \"tooltip\": \"Screen orientation.\" }"
}

if [[ -f $lock_file ]]; then
    format_output "Locked" "locked"
else
    format_output "Unlocked" "unlocked"
fi
