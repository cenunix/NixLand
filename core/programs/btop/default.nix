{ inputs
, outputs
, lib
, config
, pkgs
, ...
}:
{
  # hm.xdg.configFile = {
  #   # "btop/themes/catppuccin_mocha.theme".source = ./config/themes/catppuccin_mocha.theme;
  #   # "btop/btop.conf".source = ./config/btop.conf;
  #
  # };
  hm.home.packages = with pkgs; [ btop-cuda ];
}
