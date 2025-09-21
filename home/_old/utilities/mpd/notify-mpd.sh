mkdir $out
while "true"; do
	notify-send `Now Playing` "$($mpc/bin/mpc current --wait -f '%artist%\n%title%')" -i "$(cat $art/result)" -t 3000
	cp "$art" $out/mpd_art
done
