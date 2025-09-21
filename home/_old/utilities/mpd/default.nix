{ config, lib, pkgs, ... }:

with pkgs;
let
  hm = config.home.homeDirectory;
  /*mpd-art-path = runCommand ''mpd-art-path'' {
      		mpc = mpc_cli;
      		inherit coreutils;
      		md = "/home/jalen/Music";
      	} ''${import ./mpd-art-path.sh}''; 

      	notify-mpd = runCommand ''notify-mpd'' {
      		art = mpd-art-path.out;
      		mpc = mpc_cli;
      		inherit coreutils;
    	} ''${import ./notify-mpd.sh}'';*/
in
{
  services.mpd = {
    enable = true;
    network.startWhenNeeded = true;
    musicDirectory = "${hm}/Music"; # replace with proper non-hardcoded path
  };

  # create database file.
  systemd.user.tmpfiles.rules = [
    "f ${hm}/.config/mpd/database 0755 jalen users - -"
  ];

  # I could not get mpd to generate this conf without writing it manually.
  xdg.configFile."mpd/mpd.conf".text = ''
    		port "6600"
    		db_file "${hm}/.config/mpd/database"
    		music_directory "${hm}/Music"

    		audio_output {
    			type "pulse"
    			name "pulse audio"
    		}

    		audio_output {
    			type                    "fifo"
    			name                    "my_fifo"
    			path                    "/tmp/mpd.fifo"
    			format                  "44100:16:2"
    		}
    	'';

}
