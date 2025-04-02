{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  osConfig,
  self,
  ...
}:
with lib;
let
  catppuccin-mocha = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "discord";
    rev = "0f2c393b11dd8174002803835ef7640635100ca3";
    hash = "sha256-iUnLLAQVMXFLyoB3wgYqUTx5SafLkvtOXK6C8EHK/nI=";
  };
  device = config.modules.device;
  acceptedTypes = [
    "desktop"
    "laptop"
    "armlaptop"
  ];
in
{

  hm = mkIf (builtins.elem device.type acceptedTypes) {
    imports = [
      inputs.nixcord.homeManagerModules.nixcord
    ];
    programs.nixcord = {
      enable = true;
      config = {
        frameless = true;
        plugins = {
          clearURLs.enable = true;
          experiments.enable = true;
          f8Break.enable = true;
          fixImagesQuality.enable = true;
          fixSpotifyEmbeds.enable = true;
          fixYoutubeEmbeds.enable = true;
          gameActivityToggle.enable = true;
          hideAttachments.enable = true;
          # ignoreActivities = {
          #   enable = true;
          #   ignorePlaying = true;
          #   ignoreWatching = true;
          #   ignoredActivities = [ "someActivity" ];
          # };
          memberCount.enable = true;
          messageLogger.enable = true;
          messageClickActions.enable = true;
          newGuildSettings.enable = true;
          openInApp.enable = true;
          previewMessage.enable = true;
          readAllNotificationsButton.enable = true;
          relationshipNotifier.enable = true;
          reverseImageSearch.enable = true;
          reviewDB.enable = true;
          serverInfo.enable = true;
          shikiCodeblocks.enable = true;
          showHiddenChannels.enable = true;
          showHiddenThings.enable = true;
          showTimeoutDuration.enable = true;
          silentTyping.enable = true;
          youtubeAdblock.enable = true;
          webScreenShareFixes.enable = true;
        };
      };
    };
    # programs.home.packages = with pkgs; [ (vesktop.override { withSystemVencord = false; }) ];
    # xdg.configFile = {
    #   "vesktop/themes/mocha.theme.css" = {
    #     source = ./mocha.theme.css;
    #   };
    #
    #   # share my webcord configuration across devices
    #   "vesktop/settings/settings.json".source =
    #     config.hm.lib.file.mkOutOfStoreSymlink "/home/cenunix/NixLand/home/cenunix/graphical/apps/discord/settings.json";
    # };
  };
}
