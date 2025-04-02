{
  inputs,
  pkgs,
  config,
  lib,
  osConfig,
  ...
}:
let
  inherit (lib) mkDefault;
in
{
  home = {
    username = "cenunix";
    homeDirectory = "/home/cenunix";
    stateVersion = mkDefault "24.11";
  };
}
