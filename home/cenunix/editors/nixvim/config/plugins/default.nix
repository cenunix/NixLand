{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./colorscheme.nix
    ./neotree.nix
    ./which-key.nix
  ];
  config = {
    plugins = {
      gitsigns = {
        enable = true;
      };

      nvim-autopairs.enable = true;
      nvim-colorizer = {
        enable = true;
        userDefaultOptions.names = false;
      };
    };
  };
}