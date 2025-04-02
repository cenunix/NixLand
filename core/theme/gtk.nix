{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  osConfig,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (config.modules) device;
  inherit (config.modules.style) pointerCursor;
  acceptedTypes = [
    "desktop"
    "laptop"
    "armlaptop"
  ];

  inherit (builtins) hashString toJSON;
  rendersvg = pkgs.runCommand "rendersvg" { } ''
    mkdir -p $out/bin
    ln -s ${pkgs.resvg}/bin/resvg $out/bin/rendersvg
  '';
  materiaTheme = pkgs.stdenv.mkDerivation {
    name = "generated-gtk-theme";
    src = pkgs.fetchFromGitHub {
      owner = "nana-4";
      repo = "materia-theme";
      rev = "76cac96ca7fe45dc9e5b9822b0fbb5f4cad47984";
      sha256 = "sha256-0eCAfm/MWXv6BbCl2vbVbvgv8DiUH09TAUhoKq7Ow0k=";
    };
    buildInputs = with pkgs; [
      sassc
      bc
      which
      rendersvg
      meson
      ninja
      nodePackages.sass
      gtk4.dev
      optipng
    ];
    phases = [
      "unpackPhase"
      "installPhase"
    ];
    installPhase = ''
      HOME=/build
      chmod 777 -R .
      patchShebangs .
      mkdir -p $out/share/themes
      mkdir bin
      sed -e 's/handle-horz-.*//' -e 's/handle-vert-.*//' -i ./src/gtk-2.0/assets.txt

      cat > /build/gtk-colors << EOF
        BTN_BG=313244
        BTN_FG=cdd6f4
        BG=07070b
        FG=cdd6f4
        HDR_BTN_BG=313244
        HDR_BTN_FG=cdd6f4
        ACCENT_BG=07070b
        ACCENT_FG=cdd6f4
        HDR_BG=07070b
        HDR_FG=cdd6f4
        MATERIA_SURFACE=313244
        MATERIA_VIEW=07070b
        MENU_BG=07070b
        MENU_FG=cdd6f4
        SEL_BG=313244
        SEL_FG=cdd6f4
        TXT_BG=07070b
        TXT_FG=cdd6f4
        WM_BORDER_FOCUS=cdd6f4
        WM_BORDER_UNFOCUS=cdd6f4
        UNITY_DEFAULT_LAUNCHER_STYLE=False
        NAME=materia
        MATERIA_STYLE_COMPACT=True
      EOF

      echo "Changing colours:"
      ./change_color.sh -o "materia" /build/gtk-colors -i False -t "$out/share/themes"
      chmod 555 -R .
    '';
  };
in
rec {
  hm = mkIf (builtins.elem device.type acceptedTypes) {
    # home.pointerCursor = {
    #   package = pointerCursor.package;
    #   name = pointerCursor.name;
    #   size = pointerCursor.size;
    #   gtk.enable = true;
    #   x11.enable = true;
    # };
    gtk = {
      enable = true;
      # theme = {
      #   name = "materia";
      #   package = materiaTheme;
      # };
      # theme = {
      #   name = "Catppuccin-Mocha-Compact-Blue-Dark";
      #   package = pkgs.custom-gtk.override {
      #     accents = [ "blue" ];
      #     tweaks = [ "rimless" ];
      #     size = "compact";
      #     variant = "mocha";
      #   };
      # };
      iconTheme = {
        package = pkgs.catppuccin-papirus-folders;
        name = "Papirus";
      };
      # font = {
      #   package = pkgs.inter-nerdfont;
      #   name = "Inter Nerd Font";
      #   size = 13;
      # };
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
      # gtk2 = {
      #   configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
      #   extraConfig = ''
      #     gtk-xft-antialias=1
      #     gtk-xft-hinting=1
      #     gtk-xft-hintstyle="hintslight"
      #     gtk-xft-rgba="rgb"
      #   '';
      # };
    };
  };
}
