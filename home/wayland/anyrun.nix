{ inputs, pkgs, ... }:

{
    programs.anyrun = {
        enable = true;
        config = {
            plugins = with inputs.anyrun.packages.${pkgs.system}; [
                applications
            ];

            width.fraction = 0.3;
            y.absolute = 15;
            hidePluginInfo = true;
            closeOnClick = true;
        };
    };
}