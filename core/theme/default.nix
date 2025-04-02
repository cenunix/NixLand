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
    ./qt
    ./gtk.nix
    inputs.stylix.nixosModules.stylix
  ];
  hm.stylix = {
    # targets.spicetify.enable = false;
    targets.nvf.enable = false;
  };
  stylix = {
    enable = true;
    base16Scheme = ./theme.yaml;
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
        name = "Maple Mono SC NF";
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
