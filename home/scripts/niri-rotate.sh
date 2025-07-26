#!/bin/sh

current_rotation="$(niri msg outputs | grep Transform)"
should_rotate_counter_clockwise=0

for arg in "$@"; do
  if [[ "$arg" == "-c" ]]; then
    should_rotate_counter_clockwise=1
  fi
done

echo "Should rotate counter clockwise: $should_rotate_counter_clockwise"

orientation=0
if [[ "$current_rotation" =~ "normal" ]]; then
  orientation=0
elif [[ "$current_rotation" =~ "90" ]]; then
  orientation=90
elif [[ "$current_rotation" =~ "180" ]]; then
  orientation=180
elif [[ "$current_rotation" =~ "270" ]]; then
  orientation=270
else
  echo "Failed to determine screen orientation. Exiting..."
  exit 1
fi

if [[ $should_rotate_counter_clockwise -eq 1 ]]; then
  orientation=$(($orientation + 90))
else
  orientation=$(($orientation + 270 ))
fi

echo "$orientation"
orientation=$(($orientation % 360))
transform_mode="normal"
case $orientation in
  0) transform_mode="normal"
     ;;
  *) transform_mode="$orientation"
     ;;
esac

echo "Changing to transform $transform_mode..."
niri msg output eDP-1 transform -- $transform_mode

