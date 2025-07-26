#! /bin/sh

# Hard-coded to consider 270 degrees as "normal"
# TODO Fix this and allow for the user to set the "normal" orientation.
# TODO Allow user to set the display to rotate.

lock_file="$HOME/.local/share/niri-auto-rotate/lock"

monitor-sensor | while read line; do
  if [[ ! -f $lock_file && "$line" =~ "orientation changed:" ]]; then
    orientation="normal"

    case "$line" in
      *normal*) orientation="270"
                ;;
      *left-up*) orientation="normal"
                 ;;
      *right-up*) orientation="180"
                  ;;
      *bottom-up*) orientation="90"
                   ;;
      *) echo "Failed to determine new orientation. Exiting..."
         exit 1
         ;;
    esac

    niri msg output eDP-1 transform $orientation
  fi
done
