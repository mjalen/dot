{ config, pkgs, ... }:

let
  build-home =
    let
      hm = config.home.homeDirectory;
    in
    pkgs.writeShellScriptBin "build-home" ''
      			nix build ${hm}/Documents/dot#homeConfigurations.jalen.activationPackage && \
      			${hm}/Documents/dot/result/activate
      		'';

  mpd-art-path =
    let
      md = config.services.mpd.musicDirectory;
    in
    pkgs.writeShellScriptBin "mpd-art-path" ''
      			cover="${md}/$(mpc current -f '%artist% - %album%')/cover"
      			coverPNG="$(echo $cover).png"
      			coverJPG="$(echo $cover).jpg"
      			if [[ -e $coverPNG ]]; then
      				echo $coverPNG
      			else
      				echo $coverJPG
      			fi
      		'';

  notify-mpd = pkgs.writeShellScriptBin "notify-mpd" ''
    		while "true"; do
    			notify-send `Now Playing` "$(mpc current --wait -f '%artist%\n%title%')" \
    				-i "$(mpd-art-path)" -t 3000
    			cp "$(mpd-art-path)" /tmp/mpd_art
    		done
    	'';

in
pkgs.symlinkJoin {
  name = "scripts";
  paths = [
    build-home
    mpd-art-path
    notify-mpd

    (pkgs.writeShellScriptBin "niri-rotate"
      (builtins.readFile ./niri-rotate.sh))
    (pkgs.writeShellScriptBin "niri-auto-rotate"
      (builtins.readFile ./niri-auto-rotate.sh))
    (pkgs.writeShellScriptBin "niri-lock-rotation"
      (builtins.readFile ./niri-lock-rotation.sh))
   ];
}

