{ pkgs, ... }:

pkgs.symlinkJoin {
  name = "scripts";
  paths = [
    (pkgs.writeShellScriptBin "niri-rotate"
      (builtins.readFile ./niri-rotate.sh))
    (pkgs.writeShellScriptBin "niri-auto-rotate"
      (builtins.readFile ./niri-auto-rotate.sh))
    (pkgs.writeShellScriptBin "niri-lock-rotation"
      (builtins.readFile ./niri-lock-rotation.sh))
   ];
}

