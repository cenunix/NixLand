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
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in
{
  hm = {
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
