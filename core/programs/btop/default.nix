{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  hm.cenunix.xdg.configFile = {
    # "btop/themes/catppuccin_mocha.theme".source = ./config/themes/catppuccin_mocha.theme;
    "btop/btop.conf".source = ./config/btop.conf;

  };
  hm.cenunix.home.packages = with pkgs; [ btop-cuda ];
}
