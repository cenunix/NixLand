{ config, pkgs, ... }:
{
  config = {
    modules = {
      device = {
        type = "armlaptop";
        cpu = "snapdragon";
        gpu = "adreno";
        monitors = [ ",preferred,auto,1.2" ];
        hasBluetooth = true;
        hasSound = true;
      };
      system = {
        username = "cenunix";
        boot = {
          loader = "x13s-boot";
        };
        video.enable = true;
        sound.enable = true;
        bluetooth.enable = true;
        server = {
          enable = false;
          mediaServer = false;
        };
      };
      programs = {
        cli.enable = true;
        gui.enable = true;
        gpu-screen-recorder.enable = false;
        gaming = {
          enable = false;
          steam.enable = false;
          chess.enable = false;
          minecraft.enable = false;
          gamescope.enable = false;
        };
        default = {
          terminal = "kitty";
          fileManager = "thunar";
        };
        override = { };
      };
      style = {
        pointerCursor = {
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Ice";
          size = 24;
        };
      };
      usrEnv = {
        isWayland = true;
        desktop = "Hyprland";
        windowManager = true;
        useHomeManager = true;
        autologin = false;
      };
    };
  };
}
