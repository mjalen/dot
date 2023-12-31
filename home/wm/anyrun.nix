inputs: { lib, pkgs, ... }:

{
    programs.anyrun = {
        enable = true;
        config = {
            plugins = [
                inputs.anyrun.packages.${pkgs.system}.applications
            ];

            width = { fraction = 0.3; };
            # position = "top";
            hideIcons = false;
            layer = "overlay";
        };
    };
}