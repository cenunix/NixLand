{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  osConfig,
  ...
}:
{
  environment = {
    systemPackages = with pkgs; [
      # packages necessary for thunar thumbnails
      tumbler
      libgsf # odf files
      ffmpegthumbnailer
      kdePackages.ark # GUI archiver for thunar archive plugin
      unrar
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
      plugins = with pkgs; [
        thunar-archive-plugin
        thunar-media-tags-plugin
      ];
    };
  };
}
