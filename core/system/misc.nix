{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  device = config.modules.device;
  acceptedTypes = [
    "desktop"
    "laptop"
    "armlaptop"
  ];
in
{
  config = mkIf (builtins.elem device.type acceptedTypes) {
    # enable polkit for privilege escalation
    programs = {
      gnome-disks.enable = true;
      # nm-applet.enable = true;
      dconf.enable = true;
      wireshark.enable = true;
      seahorse.enable = true;
      nix-ld.enable = true;
    };
    services = {
      udisks2.enable = true;
      fstrim.enable = true;
      avahi.enable = true;
      gvfs.enable = true; # Mount, trash, and other functionalities
      flatpak.enable = true;
      upower.enable = device.type == "armlaptop";
      dbus = {
        packages = with pkgs; [
          dconf
          gcr
          udisks2
        ];
        enable = true;
      };
    };

    nixpkgs.config.joypixels.acceptLicense = true;

    fonts = {
      packages =
        with pkgs;
        [
          iosevka-bin
          inter
          inter-nerdfont
          font-awesome
          jetbrains-mono
          # maple-mono
          maple-mono.NF
          maple-mono.NF-CN
          lexend
          # joypixels
          fira-code
          inter
          material-symbols
        ]
        ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

      enableDefaultPackages = true;

      # this fixes emoji stuff
      fontconfig = {
        defaultFonts = {
          monospace = [
            # "Maple Mono"
            "Maple Mono SC NF"
            # "JoyPixels"
          ];
          sansSerif = [
            "Inter Nerd Font"
            "JoyPixels"
          ];
          serif = [
            "Inter Nerd Font"
            "JoyPixels"
          ];
          emoji = [ "JoyPixels" ];
        };
        # Fixes pixelation
        antialias = true;
        # Fixes antialiasing blur
        hinting = {
          enable = false;
          style = "full"; # no difference
          autohint = true; # no difference
        };
        subpixel = {
          # Makes it bolder
          rgba = "rgb";
          lcdfilter = "default"; # no difference

        };
      };
    };

    environment.pathsToLink = [
      "/share/zsh"
      "/share/bash-completion"
      "/share/nix-direnv"
    ];
  };
}
