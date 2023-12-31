{ lib, pkgs, ... }: {
    networking.nat = {
        
    };

    users.users.anon = {
        isNormalUser = true;
        description = "anon";
        home = "/home/anon";
        extraGroups = [ ]; # Enable ‘sudo’ for the user.

        hashedPasswordFile = "/nix/persist/psk/jalen";
    };

    programs.firefox.enable = true;

    system.stateVersion = "23.11";
}