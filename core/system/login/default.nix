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

    services = {
      displayManager.gdm = {
        enable = true;
      };

      logind =
        if (sys.server.enable) then
          {
            settings.Login = {
              HandleLidSwitch = "ignore";
              HandleLidSwitchExternalPower = "ignore";
            };
          }
        else
          {
            settings.Login = {
              HandlePowerKey = "suspend-then-hibernate";
              HibernateDelaySec = 3600;
              HandleLidSwitch = "suspend-then-hibernate";
              HandleLidSwitchExternalPower = "lock";
            };
          };
    };
  };
}
