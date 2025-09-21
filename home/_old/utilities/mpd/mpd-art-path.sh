# construct cover image path
mpcCmd="$mpc/bin/mpc"
currentAlbum="$(mpcCmd current -f '%album%')"
cover="$(ls -d -1 $md/**/* | grep $currentAlbum | grep cover)"

 # retrieve the first cover that can be found for a given artist
 # only when the album cover cannot be found.
#if [[ -ne cover ]]; then
#	currentArtist="$(mpcCmd current -f '%artist%')"
#	cover="$(ls -d -1 $PWD/**/* | grep $currentAlbum | grep cover)"
#fi

mkdir $out
echo $cover > $out/result

# cover="$md/$($mpcCmd current -f '%artist% - %album%')/cover"
# coverPNG="$cover.png"
#coverJPG="$cover.jpg"

# output correct file format
#if [[ -e $coverPNG ]]; then
#	echo $coverPNG > $out
#else
#	echo $coverJPG > $out
#fi
