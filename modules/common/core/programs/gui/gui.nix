{ pkgs, inputs, lib, config, ... }:
with lib;
let env = config.modules.usrEnv;
in {
  services = mkIf (env.desktop == "Plasma") {
    xserver.enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
    # pulseaudio.enable = false; 
  };
  programs.hyprland = mkIf (env.desktop == "Hyprland") { enable = true; };
  environment = {
    systemPackages = with pkgs; [
      # packages necessary for thunar thumbnails
      xfce.tumbler
      libgsf # odf files
      ffmpegthumbnailer
      ark # GUI archiver for thunar archive plugin
      sshfs # FUSE-based filesystem that allows remote filesystems to be mounted over SSH
      fuse
      cifs-utils
      keyutils
    ];
  };

  programs = {
    # enable thunar here and add plugins
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-media-tags-plugin
      ];
    };
    # registry for linux, thanks to gnome
    dconf.enable = true;
    # network inspection utility
    wireshark.enable = true;
    # gnome's keyring manager
    seahorse.enable = true;
    # networkmanager tray uility
    nm-applet.enable = true;
  };
}
