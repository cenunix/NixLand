{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  nixpkgs.overlays = [
    inputs.nur-atarax.overlays.default
  ];
  environment.systemPackages = with pkgs; [
    waydroid-helper
    waydroid-script
  ];
  virtualisation = {
    waydroid = {
      enable = true;
    };
  };
}
