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
  # nixpkgs.overlays = [ inputs.niri-flake.overlays.niri ];
  imports = [
    inputs.niri-flake.nixosModules.niri
    ./settings.nix
  ];
  hm.imports = [
    # inputs.niri-flake.homeModules.niri
    inputs.dankmaterialshell.homeModules.dankMaterialShell
  ];
  programs.niri.enable = true;
  hm = {
    home.sessionVariables = {
      # DISPLAY = ":0";
      NIXOS_OZONE_WL = "1";
    };
    home.packages = with pkgs; [
      xwayland-satellite
    ];
  };
}
