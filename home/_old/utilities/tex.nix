{ pkgs, ... }:

{
  home.packages = with pkgs; [ texliveFull ];
  /*programs.texlive = {
      		enable = true;
      		# package = pkgs.texliveFull;
    	};*/
}
