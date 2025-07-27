#! /bin/sh

path="$HOME/Pictures/Screenshots/$(date +%Y%m%d_%H%M)_screenshot.png"
echo $path
if [[ $1 =~ "-s" ]]; then
   slurp | grim -g - $path
else
    grim $path
fi
