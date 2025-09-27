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
  # nixpkgs.overlays = [ (import ./spotify-player.nix) ];
  imports = [
    ./spotify-gui.nix
  ];
  hm.cenunix.home.packages = [
    pkgs.spotify-player
  ];
}
