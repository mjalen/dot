# LXD

# Currently this LXD configuration does not work and is not used.


# [[file:../../Config.org::*LXD][LXD:1]]
{ lib, pkgs, ... }: {
  # https://srid.ca/lxc-nixos
  virtualisation.lxd.enable = true;

  virtualisation.lxd.preseed ={
    networks = [
      {
        name = "lxdbr0";
        type = "bridge";
        config = {
          "ipv4.address" = "10.0.100.1/24";
          "ipv4.nat" = "true";
        };
      }
    ];
    profiles = [
      {
        name = "default";
        devices = {
          eth0 = {
            name = "eth0";
            network = "lxdbr0";
            type = "nic";
          };
          root = {
            path = "/";
            pool = "default";
            size = "35GiB";
            type = "disk";
          };
        };
      }
    ];
    storage_pools = [
      {
        name = "default";
        driver = "dir";
        config = {
          source = "/var/lib/lxd/storage-pools/default";
        };
      }
    ];
  }; 
  /*virtualisation.lxc.systemConfig = ''
        security.nesting = true
        lxc.network.type = veth
        lxc.network.link = br0
        lxc.network.flags = up
    '';*/
}
# LXD:1 ends here
