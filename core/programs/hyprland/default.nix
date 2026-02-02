{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  osConfig,
  ...
}:
with lib;
{
  hm.imports = [
    inputs.hyprland.homeManagerModules.default
  ];
  imports = [
    ./binds.nix
    ./settings.nix
    ./rules.nix
  ];

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  hm = {
    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;

      systemd = {
        enable = false;
      };
    };
  };
}
