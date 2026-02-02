{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  osConfig,
  ...
}:
{
  hm.imports = [
    inputs.dankmaterialshell.homeModules.dankMaterialShell.default
  ];
  imports = [
    ./dms.nix
  ];
}
