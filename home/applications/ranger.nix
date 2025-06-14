{ pkgs, ... }:

{
  home.packages = with pkgs; [ ranger ];

  xdg.configFile."ranger/rc.conf".text = ''
    		set preview_images true
    		set preview_images_method kitty
    	'';

  programs.bash.bashrcExtra = ''
    		export VISUAL=vim
    		export PAGER=more
    	'';
}
