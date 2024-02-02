# TODO TexLive

# - [ ] Probably should move this elsewhere....


# [[file:../../Config.org::*TexLive][TexLive:1]]
{ pkgs, ... }:

{
	home.packages = with pkgs; [ texliveFull ];
}
# TexLive:1 ends here
