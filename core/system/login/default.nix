{
  config,
  lib,
  pkgs,
  self,
  inputs,
  ...
}:
with lib;
let
  env = config.modules.usrEnv;
  sys = config.modules.system;
in
{
  config = {
    # unlock GPG keyring on login
    security.pam.services = {
      login = {
        gnupg = {
          enable = true;
          noAutostart = true;
          storeOnly = true;
        };
      };

    };
    environment.systemPackages = with pkgs; [

      sddm-astronaut
    ];

    services = {
      displayManager.gdm = {
        enable = true;
      };
      # displayManager.sddm = {
      #   enable = false;
      #   package = pkgs.kdePackages.sddm;
      #   wayland.enable = true;
      #   theme = "sddm-astronaut-theme";
      #   # defaultSession = "hyprland";
      #   extraPackages = with pkgs; [
      #     # sddm-astronaut
      #     kdePackages.qtmultimedia
      #     kdePackages.qtvirtualkeyboard
      #     kdePackages.svgpart
      #   ];
      # };

      logind =
        if (sys.server.enable) then
          {
            lidSwitch = "ignore";
            lidSwitchExternalPower = "ignore";
          }
        else
          {
            lidSwitch = "suspend-then-hibernate";
            lidSwitchExternalPower = "lock";
            settings.Login = {
              HandlePowerKey = "suspend-then-hibernate";
              HibernateDelaySec = 3600;
            };
          };
    };
  };
}
