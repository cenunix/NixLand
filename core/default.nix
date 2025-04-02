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
  imports = [
    ./gaming
    ./programs
    ./system
    ./shell
    ./theme
    ./nix.nix
    ./packages.nix
  ];
}
