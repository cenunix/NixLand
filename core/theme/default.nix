{
  inputs,
  pkgs,
  config,
  osConfig,
  ...
}:
let
  inherit (config.modules.style) pointerCursor;
in
{
  imports = [
    ./gtk.nix
    inputs.stylix.nixosModules.stylix
  ];
  hm.stylix = {
    targets.nvf.enable = false;
    targets.firefox.enable = false;
  };
  stylix = {
    enable = true;
    base16Scheme = ./theme.yaml;
    image = ./images/blue-sky.jpg;
    fonts = {
      serif = {
        package = pkgs.inter-nerdfont;
        name = "Inter Nerd Font";
      };

      sansSerif = {
        package = pkgs.inter-nerdfont;
        name = "Inter Nerd Font";
      };

      monospace = {
        package = pkgs.maple-mono.NF-CN;
        name = "Maple Mono NF";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
    cursor = {
      inherit (pointerCursor) package name size;
    };
  };
}
