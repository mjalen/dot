{
    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        nixos-generators = {
            url = "github:nix-community/nixos-generators";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, nixos-generators, ... }: {
        packages.x86_64-linux = {
            # list of containers here.
            firefox = nixos-generators.nixosGenerate {
                system = "x86_64-linux";
                format = "lxc";
                modules = [ ./firefox.nix ];
            };
        };
    };
}