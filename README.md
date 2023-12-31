# Nix Dots 

## I am back!

I am revisiting NixOS after two/three long years full of macOS and Arch Linux (primarily the former unfortunately). I recently bought a Framework 13 laptop with a 7040 series AMD chipset and am so excited for it that I am trying to configure the software before I even get shipping info.

## Quirks

### Impermanence

I have chosen to implement impermanence into my configuration. This is done the more "advanced" way as decribed [here](https://github.com/nix-community/impermanence). There are two partitions for my SSD, boot and root. The boot partition is the standard EFI setup using `fat32`. The root partition is a `btrfs` setup that mounts `/` to a subvolume `root`. On each reboot, the `root` subvolume is copied to a new timestamped subvolume (as a backup) and wiped. I like this approach because if my system were to shutdown unexpectedly I have a convenient way to recover non-persisting files.  

### Separate Home Module

I guess this is fairly normal, but I separated my NixOS and Home-Manager configurations. This comes with the benefit of building and updating the system and users separately.

## Tasks

### Aesthetic

- [ ] Rice it up! Make it look pretty.
- [ ] Configure `waybar` so that it displays proper information.
- [ ] Write scripts to display a notification when the brightness or volume are changed.
- [ ] Try _thicc_ window borders :D.
- [ ] Window shadows.

### Backlog

- [ ] Get screen sharing + Zoom working.
- [ ] Get HDMI working. 
- [ ] Perhaps automate color picking. Probably would use `pywal` for this.
- [ ] Figure out a way to automate `rm -rf ~/.mozilla` between home builds.