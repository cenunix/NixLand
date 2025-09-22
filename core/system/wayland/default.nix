{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  env = config.modules.usrEnv;
  device = config.modules.device;
  acceptedTypes = [
    "desktop"
    "laptop"
  ];
in
{
  imports = [
    ./services.nix
    ./xdg-portals.nix
  ];

  config = mkIf (env.isWayland) {
    environment = {
      variables = {
        # NIXOS_OZONE_WL = "1";
        __GL_GSYNC_ALLOWED = "1";
        __GL_VRR_ALLOWED = "1";
        SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
        # DISABLE_QT5_COMPAT = "0";
        # ANKI_WAYLAND = "1";
        DIRENV_LOG_FORMAT = "";
        # WLR_DRM_NO_ATOMIC = "1";
        QT_AUTO_SCREEN_SCALE_FACTOR = "1";
        QT_QPA_PLATFORM = "wayland;xcb";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        QT_STYLE_OVERRIDE = lib.mkForce "kvantum";
        # MOZ_ENABLE_WAYLAND = "0"; # Firefox has a bug with 555 drivers rn :()
        # GRIMBLAST_HIDE_CURSOR = 0; # Fixes Display reloading
        # CLUTTER_BACKEND = "wayland";
        BROWSER = "librewolf";
        # WLR_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0";
      };
    };
    services = mkIf (builtins.elem device.type acceptedTypes) { pulseaudio.support32Bit = true; };

    hardware = {
      graphics = mkMerge [
        {
          enable = true;
          extraPackages = with pkgs; [
            vaapiVdpau
            libvdpau-va-gl
          ];
        }
        (mkIf (builtins.elem device.type acceptedTypes) { enable32Bit = true; })
      ];
      xone.enable = true;
    };

    environment.systemPackages =
      with pkgs;
      mkIf (env.windowManager) [
        adwaita-icon-theme
        xdg-utils
      ];
  };
}
