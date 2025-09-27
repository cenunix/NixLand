{ inputs
, outputs
, lib
, config
, pkgs
, osConfig
, ...
}:
let
  inherit (lib) mkIf;
  inherit (config.modules) device;
  acceptedTypes = [
    "desktop"
    "laptop"
    "armlaptop"
  ];
in
rec {
  hm = mkIf (builtins.elem device.type acceptedTypes) {

    gtk = {
      enable = true;

      iconTheme = {
        package = pkgs.catppuccin-papirus-folders;
        name = "Papirus";
      };

      gtk3.extraConfig = {
        gtk-toolbar-style = "GTK_TOOLBAR_BOTH";
        gtk-toolbar-icon-size = "GTK_ICON_SIZE_LARGE_TOOLBAR";
        gtk-decoration-layout = "appmenu:none";
        gtk-button-images = 1;
        gtk-menu-images = 1;
        gtk-enable-event-sounds = 0;
        gtk-enable-input-feedback-sounds = 0;
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintslight";
        gtk-error-bell = 0;
        gtk-application-prefer-dark-theme = true;
      };
    };
  };
}
