# Home Configuration

This directory contains all the `home-manager` related configurations. I did this so that I do not accidentally change my NixOS system config (duh). I try to keep most of my configurations in `home-manager` and NOT as standalone dotfiles.

The structure (which may/may not be up to date) follows:

- `./applications`: Config for different applications that can be added/removed to a user's imports in totality.
- `./users`: Different user specific configuration. Keep in mind, a user must be added to the system configuration if you actually want to use them :P. 
- `./utilities`: Services and misc modules.
- `./wayland`: Window manager and Wayland related modules. I'm more used to X11, but I decided to give Wayland a try. It seems to be the more secure option from the user perspective.
- `./themes`: Different themes I have configured.

The `home-conf.nix` file is used as a gateway between the project `flake.nix` and the user configurations. All other home modules are referenced by different users.

