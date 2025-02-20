{ inputs, outputs, lib, config, pkgs, ... }: {
  xdg.configFile = {
    "btop/themes/catppuccin_mocha.theme".source =
      ./config/themes/catppuccin_mocha.theme;
    "btop/btop.conf".source = ./config/btop.conf;

  };
  home.packages = with pkgs; [ btop-rocm ];
}
