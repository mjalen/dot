{ inputs, pkgs, ... }:

with inputs;

let
  inherit (nixpkgs.lib) nixosSystem;
  # inherit (pkgs) lib;

  valhallaModules = [
    ./valhalla

    # load from inputs
    impermanence.nixosModules.impermanence
  ];
in
{
  valhalla = nixosSystem {
    inherit pkgs;
    specialArgs = { inherit inputs; };
    modules = valhallaModules;
  };
}
