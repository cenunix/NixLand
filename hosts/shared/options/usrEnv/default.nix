{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
with lib;
{
  options.modules.usrEnv = {
    # should wayland module be loaded? this will include:
    # wayland compatibility options, wayland-only services and programs
    # and the wayland nixpkgs overlay
    isWayland = mkOption {
      type = types.bool;
      default = true;
    };

    # this option will determine what window manager/compositor/desktop environment
    # the system will use
    # TODO: make this a list
    desktop = mkOption {
      type = types.enum [
        "Hyprland"
        "i3"
        "sway"
        "Gnome"
        "Plasma"
      ];
      default = "Hyprland";
    };

    windowManager = mkOption {
      type = types.bool;
      default = false;
    };

    autologin = mkOption {
      type = types.bool;
      default = false;
    };

    # should home manager be enabled
    # you MUST to set a username if you want to use home-manager
    useHomeManager = mkOption {
      type = types.bool;
      default = true;
    };
  };
}
