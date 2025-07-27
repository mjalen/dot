{ config, lib, pkgs, ... }:

{
  imports = [ ../utilities/mpd ];
  programs.ncmpcpp = {
    enable = true;
    mpdMusicDir = config.services.mpd.musicDirectory;
    settings = {
      mpd_host = "localhost";
      mpd_port = config.services.mpd.network.port;
      visualizer_data_source = "/tmp/mpd.fifo";
      visualizer_output_name = "my_fifo";
      visualizer_in_stereo = "yes";
      visualizer_type = "wave";
      visualizer_look = "+|";
      # Fix libnotify install (for some reason notify-send is not in PATH).
      # art-path="$(${config.programs.bash.shellAliases."mpd-art-path"})"
      /*execute_on_song_change = ''
            				notify-send `Now Playing` "$(mpc --format '%title% \n%artist% - %album%' current)"
          			'';*/
    };
  };
}
