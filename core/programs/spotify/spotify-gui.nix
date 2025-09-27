{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  osConfig,
  ...
}:
with lib;
let
  device = config.modules.device;
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
  acceptedTypes = [ "desktop" ];
in
{
  hm.cenunix = mkIf (builtins.elem device.type acceptedTypes) {
    imports = [
      inputs.spicetify-nix.homeManagerModules.spicetify
    ];
    programs.spicetify = {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        adblockify
        bookmark
        keyboardShortcut
        fullAppDisplay
        shuffle # shuffle+ (special characters are sanitized out of extension names)
      ];
      # theme = spicePkgs.themes.catppuccin;
      # colorScheme = "mocha";
    };
  };
}
