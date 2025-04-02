{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
let
  browser = [ "firefox.desktop" ];
  zathura = [ "org.pwmt.zathura.desktop.desktop" ];
  filemanager = [ "dolphin.desktop" ];

  associations = {
    "text/html" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/ftp" = browser;
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/unknown" = browser;
    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/xhtml+xml" = browser;
    "application/x-extension-xhtml" = browser;
    "application/x-extension-xht" = browser;

    "audio/*" = [ "mpv.desktop" ];
    "video/*" = [ "mpv.dekstop" ];
    "image/*" = [ "imv.desktop" ];
    "application/json" = browser;
    "application/pdf" = zathura;
    "x-scheme-handler/tg" = [ "telegramdesktop.desktop" ];
    "x-scheme-handler/spotify" = [ "spotify.desktop" ];
    "x-scheme-handler/discord" = [ "WebCord.desktop" ];
    "inode/directory" = filemanager;
  };
in
{
  imports = [ ./ninja.nix ];
  hm = {
    xdg = {
      enable = true;
      cacheHome = "${config.hm.home.homeDirectory}/.cache";
      configHome = "${config.hm.home.homeDirectory}/.config";
      dataHome = "${config.hm.home.homeDirectory}/.local/share";
      stateHome = "${config.hm.home.homeDirectory}/.local/state";

      userDirs = {
        enable = true;
        createDirectories = true;

        download = "${config.hm.home.homeDirectory}/Downloads";
        desktop = "${config.hm.home.homeDirectory}/Desktop";
        documents = "${config.hm.home.homeDirectory}/Documents";

        publicShare = "${config.hm.home.homeDirectory}/.local/share/public";
        templates = "${config.hm.home.homeDirectory}/.local/share/templates";

        music = "${config.hm.home.homeDirectory}/Media/Music";
        pictures = "${config.hm.home.homeDirectory}/Media/Pictures";
        videos = "${config.hm.home.homeDirectory}/Media/Videos";

        extraConfig = {
          XDG_SCREENSHOTS_DIR = "${config.hm.xdg.userDirs.pictures}/Screenshots";
        };
      };

      mimeApps = {
        enable = true;
        associations.added = associations;
        defaultApplications = associations;
      };

    };
  };
}
