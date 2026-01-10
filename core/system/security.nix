{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  # imports = [
  #   inputs.nix-mineral/nix-mineral.nix
  # ];
  security = {
    sudo = {
      enable = true;
      execWheelOnly = true;
      extraConfig = ''
        Defaults passwd_timeout=0
        Defaults timestamp_timeout=10'';
    };
    polkit.enable = true;
  };

}
