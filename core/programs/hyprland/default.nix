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

  environment.systemPackages = with pkgs; [
    wlr-randr
    wl-clipboard
    hyprsunset
    grimblast
    brightnessctl
  ];

  hm = {
    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;

      systemd = {
        enable = false;
      };
    };
    services.hyprpaper = {
      enable = true;
    };
  };
}
