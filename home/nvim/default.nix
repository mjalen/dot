{ config, inputs, lib, ... }:

let
  hm = config.home.homeDirectory;

  # This is very brittle. Find a better alternative....
  # Perhaps define the flake absolute root in flake.nix and reference that?
  absoluteConfigPath = /home/jalen/Documents/dot/home/nvim/conf;

  # copy nvim configuration to store.
#   nvim-config = pkgs.stdenv.mkDerivation {
#     name = "nvim config";
#     src = ./conf;
#     buildInputs = with pkgs; [ coreutils ];
# 
#     buildPhase = "";
# 
#     installPhase = ''
#       			mkdir -p $out
#       			cp -r * $out/.
#       		'';
#   };
in
{
  # Symlink the nvim submodule to the XDG config directory.
  systemd.user.tmpfiles.rules = [
    "L+ ${hm}/.config/nvim/ - - - - ${absoluteConfigPath}"
  ];

  # change editor
  programs.bash.bashrcExtra = ''
	export EDITOR=vim
  '';

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };
}

