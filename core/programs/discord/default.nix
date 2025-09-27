{ inputs
, outputs
, lib
, config
, pkgs
, osConfig
, self
, ...
}:
with lib;
let

  device = config.modules.device;
  acceptedTypes = [
    "desktop"
    "laptop"
  ];
in
{

  hm = mkIf (builtins.elem device.type acceptedTypes) {
    imports = [
      inputs.nixcord.homeModules.nixcord
    ];
    programs.nixcord = {
      enable = true;
      config = {
        frameless = true;
        plugins = {
          clearURLs.enable = true;
          # experiments.enable = true;
          f8Break.enable = true;
          fixImagesQuality.enable = true;
          fixSpotifyEmbeds.enable = true;
          fixYoutubeEmbeds.enable = true;
          gameActivityToggle.enable = true;
          hideMedia.enable = true;
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
  };
}
