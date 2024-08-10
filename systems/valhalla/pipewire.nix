{ config, lib, pkgs, ... }: {
  security.rtkit.enable = true;
  services.pipewire = {
    pulse.enable = true;
  };
}
