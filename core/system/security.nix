{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    "${inputs.nix-mineral}/nix-mineral.nix"
  ];
}
