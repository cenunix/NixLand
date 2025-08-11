{
  inputs,
  pkgs,
  config,
  osConfig,
  self,
  ...
}:
{
  imports = [
    ./spotify-gui.nix
    ./spotify-player.nix
  ];
}
