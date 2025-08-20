{
  inputs,
  pkgs,
  config,
  osConfig,
  self,
  lib,
  ...
}:
{
  nixpkgs.overlays = [ (import ./spotify-player.nix) ];
  imports = [
    ./spotify-gui.nix
  ];
  hm.home.packages = [
    pkgs.spotify-player
  ];
}
