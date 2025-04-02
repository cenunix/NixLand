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
  hm.imports = [ inputs.hyprland.homeManagerModules.default ];
  imports = [
    ./binds.nix
    ./settings.nix
    ./rules.nix
  ];

  programs.hyprland.enable = true;
  hm.home.packages = with pkgs; [
    wlr-randr
    wl-clipboard
    hyprsunset
    grimblast
  ];

  # fake a tray to let apps start
  # https://github.com/nix-community/home-manager/issues/2064
  # TEST ME
  hm.systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
  };

  hm.wayland.windowManager.hyprland = {
    enable = true;

    systemd = {
      enable = true;
      variables = [ "--all" ];
    };
  };

}
