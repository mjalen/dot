# Nix Dots 

## I am back!

I am revisiting NixOS after two/three long years full of macOS and Arch Linux (mostly the former unfortunately). I just ordered a Framework 13 laptop with a 7040 series AMD chipset and am so excited for it that I am trying to configure the software before I even get shipping info.

## Notes

- To use dots, run `$ nixos-rebuild swtich --flake github:mjalen/dot`. Obviously, flakes must be enabled.
- To update the home config, I am using the more verbose method to get used to the `nix` CLI:

``` sh
$ nix build github:mjalen/dot#homeConfigurations.<user>.activationPackage
$ result/activate
```

Perhaps it would be nice to auto-delete the `result` directory that is created from this process.

- For now, I will be building from my GitHub repo. The reason for this is to force myself to commit my changes often (Otherwise I would forget and would have a very out-dated configuration here).
